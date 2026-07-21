// lib/core/services/voice_note_service.dart
//
// Records a short voice note (m4a/AAC), samples amplitude while recording
// to build a lightweight waveform (~40 bars, not a full audio analysis —
// good enough for a WhatsApp-style static waveform), uploads it via the
// same Cloudflare Worker used for post images (audio just gets a
// different key prefix: voice-notes/{uid}/... instead of posts/{uid}/...),
// then writes a comment document referencing it.
//
// Requires the `record` package:
//   flutter pub add record
//
// Requires mic permission declared natively (already added):
//   iOS: NSMicrophoneUsageDescription in Info.plist
//   Android: RECORD_AUDIO in AndroidManifest.xml

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'post_interaction_service.dart';

class VoiceNoteService {
  VoiceNoteService._();

  // Same Worker as post images — it now also accepts m4a/aac/mp3 and
  // routes them to a `voice-notes/` key prefix instead of `posts/`.
  static const String _workerUploadUrl =
      'https://edulink-r2-upload.edulinkore.workers.dev';

  static final AudioRecorder _recorder = AudioRecorder();
  static StreamSubscription<Amplitude>? _ampSub;
  static final List<double> _rawAmps = [];
  static DateTime? _startedAt;

  /// Starts recording. Throws if mic permission is denied.
  static Future<void> startRecording() async {
    if (!await _recorder.hasPermission()) {
      throw Exception('Microphone permission denied');
    }
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    _rawAmps.clear();
    _startedAt = DateTime.now();

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );

    // Sample amplitude a few times a second to build a waveform. Values
    // from the `record` package are in dBFS (roughly -45 to 0); we
    // normalize to 0.0–1.0 for rendering.
    _ampSub = _recorder
        .onAmplitudeChanged(const Duration(milliseconds: 120))
        .listen((amp) {
      final normalized = ((amp.current + 45) / 45).clamp(0.0, 1.0);
      _rawAmps.add(normalized);
    });
  }

  /// Stops recording and returns the local file, raw duration, and a
  /// downsampled ~40-point waveform. Returns null if nothing was recorded
  /// (e.g. stopped almost instantly).
  static Future<RecordingResult?> stopRecording() async {
    await _ampSub?.cancel();
    _ampSub = null;
    final path = await _recorder.stop();
    final durationMs = _startedAt == null
        ? 0
        : DateTime.now().difference(_startedAt!).inMilliseconds;
    _startedAt = null;

    if (path == null || durationMs < 500) {
      if (path != null) {
        final f = File(path);
        if (await f.exists()) await f.delete();
      }
      return null;
    }

    return RecordingResult(
      file: File(path),
      durationMs: durationMs,
      waveform: _downsample(_rawAmps, 40),
    );
  }

  /// Cancels an in-progress recording without saving anything.
  static Future<void> cancelRecording() async {
    await _ampSub?.cancel();
    _ampSub = null;
    final path = await _recorder.stop();
    _startedAt = null;
    if (path != null) {
      final f = File(path);
      if (await f.exists()) await f.delete();
    }
  }

  static List<double> _downsample(List<double> raw, int targetCount) {
    if (raw.isEmpty) return List.filled(targetCount, 0.1);
    if (raw.length <= targetCount) {
      return [...raw, ...List.filled(targetCount - raw.length, 0.1)];
    }
    final bucketSize = raw.length / targetCount;
    return List.generate(targetCount, (i) {
      final start = (i * bucketSize).floor();
      final end = ((i + 1) * bucketSize).floor().clamp(start + 1, raw.length);
      final bucket = raw.sublist(start, end);
      return bucket.reduce((a, b) => a + b) / bucket.length;
    });
  }

  /// Uploads a recorded voice note file to R2 via the Worker and returns
  /// its public URL. Used by both post creation and comment replies —
  /// callers decide what document to attach the URL to.
  static Future<String> uploadVoiceNote(File file) async {
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
      body: jsonEncode({'ext': 'm4a'}),
    );

    if (presignRes.statusCode != 200) {
      throw Exception(
          'Could not get upload URL (${presignRes.statusCode}): ${presignRes.body}');
    }

    final presignData = jsonDecode(presignRes.body) as Map<String, dynamic>;
    final uploadUrl = presignData['uploadUrl'] as String?;
    final publicUrl = presignData['publicUrl'] as String?;
    final contentType = presignData['contentType'] as String? ?? 'audio/m4a';
    if (uploadUrl == null || publicUrl == null) {
      throw Exception('Worker response missing uploadUrl/publicUrl');
    }

    final bytes = await file.readAsBytes();
    final putRes = await http.put(
      Uri.parse(uploadUrl),
      headers: {'Content-Type': contentType},
      body: bytes,
    );
    if (putRes.statusCode != 200) {
      throw Exception('Voice note upload failed (${putRes.statusCode})');
    }

    try {
      await file.delete();
    } catch (_) {}

    return publicUrl;
  }

  /// Uploads the recorded file and posts it as a voice-note comment.
  static Future<void> sendAsComment({
    required String postId,
    required File file,
    required int durationMs,
    required List<double> waveform,
  }) async {
    final publicUrl = await uploadVoiceNote(file);
    await PostInteractionService.addVoiceComment(
      postId: postId,
      audioUrl: publicUrl,
      durationMs: durationMs,
      waveform: waveform,
    );
  }
}

class RecordingResult {
  final File file;
  final int durationMs;
  final List<double> waveform;
  RecordingResult({
    required this.file,
    required this.durationMs,
    required this.waveform,
  });
}