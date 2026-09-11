// lib/core/services/post_video_upload_service.dart
//
// Lets users post a short video to the social feed. Two steps:
//   1. Compress on-device via FFmpeg (same settings as the admin upload
//      tool's Insights pipeline: 720p, CRF 28) -- keeps upload size and
//      time reasonable on a typical mobile connection.
//   2. Upload through the SAME Worker post images and voice notes
//      already use (edulink-r2-upload.edulinkore.workers.dev), passing
//      ext: 'mp4'. That worker already handles multiple content types
//      dynamically (voice notes proved this by adding m4a without any
//      worker-side changes needed) -- this is a reasonable bet that mp4
//      works the same way, but it's an assumption, not a confirmed fact,
//      since this worker's own source was never reviewed here. If the
//      presign step rejects 'mp4', that worker's code needs a look,
//      same as we did for the study-chat worker's index.js earlier.
//
// Deliberately capped at 60 seconds -- long enough for a real clip,
// short enough to keep compression time and upload size sane on a
// typical mobile connection. Adjust _maxDurationSeconds if that's wrong.

import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';

class PostVideoUploadService {
  PostVideoUploadService._();

  static const String _workerUploadUrl =
      'https://edulink-r2-upload.edulinkore.workers.dev';

  static const int maxDurationSeconds = 60;

  /// Compresses the video on-device, then uploads it. Returns the
  /// public URL. Throws if compression or upload fails.
  static Future<String> compressAndUpload(
    File rawVideo, {
    void Function(String status)? onStatus,
  }) async {
    onStatus?.call('Compressing...');
    final compressed = await _compress(rawVideo);

    onStatus?.call('Uploading...');
    final url = await _upload(compressed);

    try {
      await compressed.delete();
    } catch (_) {}

    return url;
  }

  static Future<File> _compress(File input) async {
    final dir = await getTemporaryDirectory();
    final outputPath =
        '${dir.path}/post_video_${DateTime.now().millisecondsSinceEpoch}.mp4';

    // Same settings as the admin upload tool's Insights pipeline, for
    // consistent quality/size across every video in the app -- except
    // preset, bumped from 'fast' to 'veryfast' for meaningfully quicker
    // compression. Trade-off: slightly larger output for the same CRF,
    // but compression speed was the actual complaint, and this is a
    // real, direct lever for it without dropping resolution/quality.
    final cmd = '-i "${input.path}" '
        '-vf "scale=720:-2" '
        '-c:v libx264 -crf 28 -preset veryfast '
        '-c:a aac -b:a 96k '
        '-movflags +faststart '
        '-t $maxDurationSeconds ' // hard-trims anything longer, belt-and-braces
        '-y "$outputPath"';

    final session = await FFmpegKit.execute(cmd);
    final rc = await session.getReturnCode();
    if (!ReturnCode.isSuccess(rc)) {
      final log = await session.getAllLogsAsString();
      throw Exception('Video compression failed: $log');
    }

    final output = File(outputPath);
    if (!await output.exists()) {
      throw Exception('Compression completed but no output file was produced');
    }
    return output;
  }

  static Future<String> _upload(File file) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not logged in');
    final idToken = await user.getIdToken();
    if (idToken == null) throw Exception('Could not get auth token');

    final presignRes = await http.post(
      Uri.parse(_workerUploadUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: jsonEncode({'ext': 'mp4'}),
    );

    if (presignRes.statusCode != 200) {
      throw Exception(
          'Could not get upload URL (${presignRes.statusCode}): ${presignRes.body}');
    }

    final presignData = jsonDecode(presignRes.body) as Map<String, dynamic>;
    final uploadUrl = presignData['uploadUrl'] as String?;
    final publicUrl = presignData['publicUrl'] as String?;
    final contentType = presignData['contentType'] as String? ?? 'video/mp4';
    if (uploadUrl == null || publicUrl == null) {
      throw Exception('Worker response missing uploadUrl/publicUrl');
    }

    // Streamed, not http.put(body: bytes) -- the previous version read
    // the entire compressed file into memory first, then sent it as a
    // single, non-streamed block. For a multi-MB video on an unstable
    // mobile connection, that's a real, direct cause of the
    // "ClientException: Read failed" error -- the server side timing
    // out or dropping the connection partway through a large,
    // all-at-once body. StreamedRequest sends the file straight from
    // disk in chunks instead.
    //
    // One retry on failure -- a single dropped connection on mobile
    // data is common enough to be worth one automatic second attempt
    // before actually failing the post.
    Object? lastError;
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final length = await file.length();
        final request = http.StreamedRequest('PUT', Uri.parse(uploadUrl))
          ..headers['Content-Type'] = contentType
          ..contentLength = length;
        file.openRead().listen(
          request.sink.add,
          onDone: request.sink.close,
          onError: request.sink.addError,
        );

        final streamedRes = await request.send();
        if (streamedRes.statusCode != 200) {
          throw Exception('Video upload failed (${streamedRes.statusCode})');
        }
        return publicUrl;
      } catch (e) {
        lastError = e;
        if (attempt == 0) {
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    }
    throw lastError ?? Exception('Video upload failed after retry');
  }
}