// lib/core/services/video_watermark_service.dart
//
// Downloads a video from R2, burns a watermark into it using FFmpeg,
// saves the result to the device gallery, and optionally shares the
// file or a link via the OS share sheet.
//
// CURRENT scope (Insights only, Edulink as uploader):
//   Watermark = Edulink logo (bottom-left) + channel name (bottom-right)
//
// FUTURE scope (creator videos, user posts on social feed):
//   Pass `creatorName` to add the creator's display name to the watermark.
//   The FFmpeg drawtext filter chain already supports this — the caller
//   just needs to supply the non-null creatorName parameter.
//
// Packages required (add to pubspec.yaml before use):
//   ffmpeg_kit_flutter_new: ^6.0.3
//   gal: ^2.3.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:gal/gal.dart';

/// Result of a save-to-gallery attempt. `watermarked: false` means the
/// FFmpeg burn-in failed and the clean original was saved instead — the
/// caller should tell the user honestly rather than claiming success
/// unconditionally.
class WatermarkResult {
  final String path;
  final bool watermarked;
  final String? ffmpegLog;
  const WatermarkResult({required this.path, required this.watermarked, this.ffmpegLog});
}

class VideoWatermarkService {
  VideoWatermarkService._();

  // Public R2 base — same as everywhere else in the app.
  static const String _r2Base =
      'https://pub-3c266d2c4f6a489fa6294e6dafcb9e20.r2.dev';

  // The Edulink logo asset is copied to a temp path at first use, since
  // FFmpeg needs a filesystem path, not an asset bundle path.
  static String? _logoTempPath;
  static String? _fontTempPath;

  /// Shows the bottom sheet the user sees when they tap the Share button.
  /// [videoId]    — the Firestore/R2 document id (also the R2 key stem).
  /// [videoUrl]   — the full public R2 URL.
  /// [channel]    — the sub-channel name shown on the watermark.
  /// [caption]    — used as the share message text.
  /// [creatorName]— null for Edulink-posted videos; supply for future
  ///                creator/user-posted content.
  static Future<void> showShareSheet(
    BuildContext context, {
    required String videoId,
    required String videoUrl,
    required String channel,
    required String caption,
    String? creatorName,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ShareSheet(
        videoId: videoId,
        videoUrl: videoUrl,
        channel: channel,
        caption: caption,
        creatorName: creatorName,
      ),
    );
  }

  /// Downloads [videoUrl], burns the watermark in via FFmpeg, and saves
  /// the result to the device gallery. Progress is reported via
  /// [onProgress] (0.0 – 1.0).
  ///
  /// Returns the path of the watermarked file, or null on failure.
  static Future<WatermarkResult?> downloadWithWatermark({
    required String videoId,
    required String videoUrl,
    required String channel,
    String? creatorName,
    void Function(double progress, String status)? onProgress,
  }) async {
    try {
      // ── 1. Download the source video ─────────────────────────────────
      onProgress?.call(0.05, 'Downloading video…');
      final tmpDir = await getTemporaryDirectory();
      final sourcePath = '${tmpDir.path}/wm_src_$videoId.mp4';
      final outputPath = '${tmpDir.path}/wm_out_$videoId.mp4';

      final resp = await http.get(Uri.parse(videoUrl));
      if (resp.statusCode != 200) {
        onProgress?.call(0.0, 'Download failed (${resp.statusCode})');
        return null;
      }
      await File(sourcePath).writeAsBytes(resp.bodyBytes);
      onProgress?.call(0.35, 'Applying watermark…');

      // ── 2. Write the logo asset to a temp path ───────────────────────
      _logoTempPath ??= await _extractLogoAsset(tmpDir.path);
      // Android's stripped-down FFmpeg build has no system font database,
      // so drawtext can't resolve a font by family name ("Sans") at all —
      // it fails with "Cannot find a valid font for the family Sans" and
      // aborts filter graph init entirely. An explicit fontfile= path to
      // a bundled TTF is required.
      _fontTempPath ??= await _extractFontAsset(tmpDir.path);
      final fontClause = _fontTempPath != null
          ? "fontfile='$_fontTempPath':"
          : '';

      // ── 3. Build the FFmpeg filter chain ─────────────────────────────
      //
      // Glitch watermark: three copies of the logo tinted purple, pink,
      // and white, each offset a few pixels from the others. This gives
      // a permanent chromatic-aberration look — the RGB-split signature —
      // burnt into the saved file. (A periodic "snap" that exaggerates
      // the offset every few seconds is a nice-to-have for later; it
      // needs FFmpeg's `enable` option applied correctly per-filter
      // rather than embedded inside x/y expressions, which is what
      // broke silently on the first attempt.)
      final safeChannel = _escapeDrawtext(channel);

      String filterComplex;

      if (_logoTempPath != null) {
        final logoW = 'iw*0.11'; // ~11% of video width
        final bx = 14; // base X (bottom-left)

        final splitFilter = '[1:v]split=3[l1][l2][l3]';
        final purpleFilter =
            '[l1]scale=$logoW:-1,'
            'colorchannelmixer=rr=0.3:gg=0.1:bb=1.0:aa=0.55[purple]';
        final pinkFilter =
            '[l2]scale=$logoW:-1,'
            'colorchannelmixer=rr=0.9:gg=0.2:bb=0.7:aa=0.55[pink]';
        final whiteFilter =
            '[l3]scale=$logoW:-1,'
            'colorchannelmixer=rr=1:gg=1:bb=1:aa=0.80[white]'; 

        // Fixed pixel offsets — no quoted expressions, no time functions.
        // purple: (bx-3, by-3) · pink: (bx+3, by+3) · white: (bx, by)
        final overlays =
            '[0:v][purple]overlay=${bx - 3}:H-h-${14 + 3}[v1];'
            '[v1][pink]overlay=${bx + 3}:H-h-${14 - 3}[v2];'
            '[v2][white]overlay=$bx:H-h-14[vlogo]';

        final chanText =
            'drawtext=text=\'$safeChannel\':$fontClause'
            'fontcolor=white:fontsize=h/28:'
            'x=W-tw-14:y=H-th-14:'
            'shadowcolor=black:shadowx=1:shadowy=1';

        if (creatorName != null && creatorName.isNotEmpty) {
          final safeCreator = _escapeDrawtext(creatorName);
          final creatorText =
              'drawtext=text=\'$safeCreator\':$fontClause'
              'fontcolor=white:fontsize=h/32:'
              'x=W-tw-14:y=H-th-46:'
              'shadowcolor=black:shadowx=1:shadowy=1';
          filterComplex =
              '$splitFilter;$purpleFilter;$pinkFilter;$whiteFilter;'
              '$overlays;[vlogo]$chanText,$creatorText[out]';
        } else {
          filterComplex =
              '$splitFilter;$purpleFilter;$pinkFilter;$whiteFilter;'
              '$overlays;[vlogo]$chanText[out]';
        }
      } else {
        // Logo unavailable — text-only fallback.
        final chanText =
            'drawtext=text=\'Edulink\':$fontClause'
            'fontcolor=white:fontsize=h/30:'
            'x=14:y=H-th-14:'
            'shadowcolor=black:shadowx=1:shadowy=1,'
            'drawtext=text=\'$safeChannel\':$fontClause'
            'fontcolor=white:fontsize=h/30:'
            'x=W-tw-14:y=H-th-14:'
            'shadowcolor=black:shadowx=1:shadowy=1';
        filterComplex = '[0:v]$chanText[out]';
      }

      // ── 4. Build the full FFmpeg command ─────────────────────────────
      final logoInput = _logoTempPath != null ? '-i "$_logoTempPath"' : '';
      final cmd =
          '-i "$sourcePath" $logoInput '
          '-filter_complex "$filterComplex" '
          '-map "[out]" -map 0:a? '  // keep audio if present
          '-c:v libx264 -preset fast -crf 23 '
          '-c:a copy '
          '-movflags +faststart '
          '-y "$outputPath"';

      // ── 5. Run FFmpeg ─────────────────────────────────────────────────
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();

      if (!ReturnCode.isSuccess(rc)) {
        final logs = await session.getAllLogsAsString();
        debugPrint('[watermark] FFmpeg failed:\n$logs');
        onProgress?.call(0.0, 'Watermark failed — saving original…');
        // Graceful fallback: save the clean video without a watermark
        // rather than leaving the user with nothing. `watermarked: false`
        // lets the caller show an honest message instead of pretending
        // the watermark applied.
        await Gal.putVideo(sourcePath);
        _cleanup([sourcePath]);
        return WatermarkResult(path: sourcePath, watermarked: false, ffmpegLog: logs);
      }

      onProgress?.call(0.85, 'Saving to gallery…');

      // ── 6. Save to gallery ───────────────────────────────────────────
      await Gal.putVideo(outputPath);
      onProgress?.call(1.0, 'Saved!');

      _cleanup([sourcePath, outputPath]);
      return WatermarkResult(path: outputPath, watermarked: true, ffmpegLog: null);
    } catch (e) {
      debugPrint('[watermark] error: $e');
      onProgress?.call(0.0, 'Something went wrong.');
      return null;
    }
  }

  /// Shares a plain text link + caption via the OS share sheet
  /// (WhatsApp, Twitter, copy link, etc.). No video download involved.
  static Future<void> shareLink({
    required String videoId,
    required String caption,
  }) async {
    // Deep-link format — the app can handle this route later for
    // in-app opens; for now it's a shareable URL with context.
    final link = '$_r2Base/$videoId.mp4';
    await SharePlus.instance.share(
      ShareParams(
        text: '$caption\n\nWatched on Edulink 🎓\n$link',
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────

  static Future<String?> _extractLogoAsset(String tmpDir) async {
    try {
      final path = '$tmpDir/edulink_logo.png';
      // Load from the Flutter asset bundle (same as Image.asset would)
      // and write it to disk so FFmpeg can reference it by path.
      final data = await _loadAssetBytes('assets/images/edulink_logo.png');
      await File(path).writeAsBytes(data);
      return path;
    } catch (e) {
      debugPrint('[watermark] could not extract logo asset: $e');
      return null;
    }
  }

  /// Extracts the bundled DM Sans TTF so drawtext has an explicit font
  /// file to point at. Without this, drawtext tries to resolve a font
  /// by family name via fontconfig — which Android's stripped FFmpeg
  /// build doesn't have, so it fails outright with "Cannot find a valid
  /// font for the family Sans" and aborts the whole filter graph.
  static Future<String?> _extractFontAsset(String tmpDir) async {
    try {
      final path = '$tmpDir/DMSans.ttf';
      final data = await _loadAssetBytes('assets/fonts/DMSans.ttf');
      await File(path).writeAsBytes(data);
      return path;
    } catch (e) {
      debugPrint('[watermark] could not extract font asset: $e');
      return null;
    }
  }

  static Future<List<int>> _loadAssetBytes(String assetPath) async {
    final bundle = PlatformAssetBundle();
    final data = await bundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  static String _escapeDrawtext(String text) =>
      text.replaceAll("'", r"\'").replaceAll(':', r'\:');

  static void _cleanup(List<String> paths) {
    for (final p in paths) {
      try {
        final f = File(p);
        if (f.existsSync()) f.deleteSync();
      } catch (_) {}
    }
  }
}

// ── Share bottom sheet ────────────────────────────────────────────────────

class _ShareSheet extends StatefulWidget {
  final String videoId, videoUrl, channel, caption;
  final String? creatorName;
  const _ShareSheet({
    required this.videoId, required this.videoUrl,
    required this.channel, required this.caption,
    this.creatorName,
  });

  @override
  State<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<_ShareSheet> {
  bool _downloading = false;
  double _progress = 0;
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Drag handle
          Container(width: 36, height: 4,
            decoration: BoxDecoration(
              color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          const Text('Share', style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          if (_downloading) ...[
            LinearProgressIndicator(value: _progress,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7C3AED))),
            const SizedBox(height: 10),
            Text(_status, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 20),
          ] else ...[
            _Option(
              icon: Icons.download_rounded,
              label: 'Save to gallery',
              sublabel: 'Downloads with Edulink watermark',
              onTap: _saveToGallery,
            ),
            const SizedBox(height: 12),
            _Option(
              icon: Icons.link_rounded,
              label: 'Share link',
              sublabel: 'Send to WhatsApp, Twitter, and more',
              onTap: () async {
                Navigator.pop(context);
                await VideoWatermarkService.shareLink(
                  videoId: widget.videoId,
                  caption: widget.caption,
                );
              },
            ),
          ],
        ]),
      ),
    );
  }

  Future<void> _saveToGallery() async {
    setState(() { _downloading = true; _progress = 0.05; _status = 'Starting…'; });

    final result = await VideoWatermarkService.downloadWithWatermark(
      videoId: widget.videoId,
      videoUrl: widget.videoUrl,
      channel: widget.channel,
      creatorName: widget.creatorName,
      onProgress: (p, s) {
        if (mounted) setState(() { _progress = p; _status = s; });
      },
    );

    if (mounted) {
      Navigator.pop(context);
      final ok = result != null;
      final watermarked = result?.watermarked ?? false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          !ok ? 'Couldn\'t save the video — try again.'
              : watermarked ? 'Saved to your gallery 🎉'
              : 'Saved, but the watermark didn\'t apply.',
        ),
        backgroundColor: !ok ? Colors.redAccent
            : watermarked ? const Color(0xFF7C3AED) : Colors.orange,
        duration: const Duration(seconds: 3),
      ));
    }
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String label, sublabel;
  final VoidCallback onTap;
  const _Option({required this.icon, required this.label,
    required this.sublabel, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: const Color(0xFF9D6FFF), size: 22)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          Text(sublabel, style: const TextStyle(
            color: Colors.white54, fontSize: 12)),
        ])),
        const Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 20),
      ]),
    ),
  );
}