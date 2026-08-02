// lib/core/services/active_now_service.dart
//
// Powers the "active now" strip — who among the people you follow is
// currently online. Deliberately POLLED, not a live listener.
//
// Why polling matters here specifically: every online user's device
// writes a presence heartbeat roughly every 75 seconds (see
// PresenceService). If the active-now strip were a LIVE listener on
// those same documents, every single heartbeat from every followed
// user would re-fire the listener for everyone watching their strip —
// one person's routine activity billing many other people's screens.
// That's the same shape of problem as the old like-count bug (one
// write fanning out into many reads), just triggered by heartbeats
// instead of likes. Polling every 45s instead of listening live avoids
// it entirely — nobody needs millisecond-accurate "who's online".
//
// Also scoped to people you follow, not the whole user base — smaller
// query, and a more relevant result (seeing strangers is noise, seeing
// people you know is signal).
//
// Firestore rule: none needed beyond what already exists — users/{id}
// is already readable by any signed-in user.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'presence_service.dart';
import 'user_follow_service.dart';

class ActiveNowService {
  ActiveNowService._();

  static const Duration pollInterval = Duration(seconds: 45);

  // Firestore's whereIn caps at 30 values per query — chunk if someone
  // follows more than that, rather than silently truncating their list.
  static const int _whereInChunkSize = 30;

  /// Emits the list of currently-active users among who you follow,
  /// re-checked every [pollInterval]. Each emission is a fresh read,
  /// not a standing listener — see file header for why that matters.
  static Stream<List<Map<String, dynamic>>> activeFollowing() {
    late StreamController<List<Map<String, dynamic>>> controller;
    Timer? timer;

    Future<void> poll() async {
      try {
        final followingIds = await UserFollowService.myFollowingUids();
        if (followingIds.isEmpty) {
          controller.add([]);
          return;
        }

        final idList = followingIds.toList();
        final results = <Map<String, dynamic>>[];

        for (var i = 0; i < idList.length; i += _whereInChunkSize) {
          final chunk = idList.sublist(
            i, (i + _whereInChunkSize > idList.length) ? idList.length : i + _whereInChunkSize);
          final snap = await FirebaseFirestore.instance
              .collection('users')
              .where(FieldPath.documentId, whereIn: chunk)
              .get();
          for (final doc in snap.docs) {
            final data = doc.data();
            if (PresenceService.isOnline(data['lastActiveAt'] as Timestamp?)) {
              results.add({'uid': doc.id, ...data});
            }
          }
        }
        controller.add(results);
      } catch (_) {
        controller.add([]);
      }
    }

    controller = StreamController<List<Map<String, dynamic>>>.broadcast(
      onListen: () {
        poll();
        timer = Timer.periodic(pollInterval, (_) => poll());
      },
      onCancel: () {
        timer?.cancel();
      },
    );

    return controller.stream;
  }
}