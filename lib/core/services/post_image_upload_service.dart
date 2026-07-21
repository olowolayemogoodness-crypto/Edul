import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

/// Uploads post images via a Cloudflare Worker that mints short-lived,
/// presigned R2 upload URLs — the app never holds R2 write credentials.
class PostImageUploadService {
  static const String _workerUploadUrl =
      'https://edulink-r2-upload.edulinkore.workers.dev';

  static Future<List<String>> uploadAll(
    List<File> files, {
    void Function(double progress)? onProgress,
  }) async {
    if (files.isEmpty) return [];

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not logged in');
    final idToken = await user.getIdToken();
    if (idToken == null) throw Exception('Could not get auth token');

    final urls = <String>[];
    for (var i = 0; i < files.length; i++) {
      final url = await _uploadOne(files[i], index: i, idToken: idToken);
      urls.add(url);
      onProgress?.call((i + 1) / files.length);
    }
    return urls;
  }

  static Future<String> _uploadOne(
    File file, {
    required int index,
    required String idToken,
  }) async {
    final ext = file.path.split('.').last.toLowerCase();
    final safeExt = ['jpg', 'jpeg', 'png', 'webp'].contains(ext) ? ext : 'jpg';

    final presignRes = await http.post(
      Uri.parse(_workerUploadUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: jsonEncode({'ext': safeExt, 'index': index}),
    );

    if (presignRes.statusCode != 200) {
      throw Exception(
          'Could not get upload URL (${presignRes.statusCode}): ${presignRes.body}');
    }

    final presignData = jsonDecode(presignRes.body) as Map<String, dynamic>;
    final uploadUrl = presignData['uploadUrl'] as String?;
    final publicUrl = presignData['publicUrl'] as String?;
    final contentType = presignData['contentType'] as String? ?? 'image/jpeg';

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
      throw Exception('Image upload failed (${putRes.statusCode})');
    }

    return publicUrl;
  }
}