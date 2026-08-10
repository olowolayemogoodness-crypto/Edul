// lib/core/services/study_room_service.dart
//
// Data layer for Live Study Rooms. Mirrors the Firestore schema enforced by
// firestore.rules: study_rooms/{roomId} with participants/, messages/, and
// reports/ subcollections.
//
// Attachment uploads (images/PDFs shared in chat) go through a Cloudflare
// Worker that mints a presigned R2 PUT URL -- set studyChatWorkerUrl below
// once that Worker is deployed. Until then, sendImageMessage/sendPdfMessage
// will throw a clear error rather than silently failing.

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

// ── Models ───────────────────────────────────────────────────────────────

class StudyRoom {
  final String id;
  final String title;
  final String hostId;
  final String? courseTag;
  final int maxParticipants;
  final int participantCount;
  final int durationMinutes;
  final DateTime startTimestamp;
  final DateTime endTimestamp;
  final String status; // 'active' | 'expired'

  const StudyRoom({
    required this.id,
    required this.title,
    required this.hostId,
    required this.courseTag,
    required this.maxParticipants,
    required this.participantCount,
    required this.durationMinutes,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.status,
  });

  bool get isFull => participantCount >= maxParticipants;

  // Client-side truth for "has this room's time run out" -- don't wait on
  // the cron sweep to flip `status`, the UI should react the instant the
  // countdown hits zero.
  bool get isExpiredNow => DateTime.now().isAfter(endTimestamp);

  Duration get remaining => endTimestamp.difference(DateTime.now());

  factory StudyRoom.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return StudyRoom(
      id: doc.id,
      title: d['title'] as String,
      hostId: d['host_id'] as String,
      courseTag: d['course_tag'] as String?,
      maxParticipants: d['max_participants'] as int,
      participantCount: d['participant_count'] as int,
      durationMinutes: d['duration_minutes'] as int,
      startTimestamp: (d['start_timestamp'] as Timestamp).toDate(),
      endTimestamp: (d['end_timestamp'] as Timestamp).toDate(),
      status: d['status'] as String,
    );
  }
}

class StudyRoomParticipant {
  final String userId;
  final String displayName;
  final DateTime joinedAt;

  const StudyRoomParticipant({
    required this.userId,
    required this.displayName,
    required this.joinedAt,
  });

  factory StudyRoomParticipant.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return StudyRoomParticipant(
      userId: doc.id,
      displayName: d['display_name'] as String? ?? 'Student',
      joinedAt: (d['joined_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

enum StudyRoomMessageType { text, image, pdf, voice }

class StudyRoomMessage {
  final String id;
  final String senderId;
  final String senderName;
  final StudyRoomMessageType type;
  final String content; // text body, or the R2 URL for image/pdf/voice
  final String? fileName;
  final int? durationMs; // voice notes only
  final List<double>? waveform; // voice notes only
  final DateTime timestamp;

  const StudyRoomMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.type,
    required this.content,
    required this.fileName,
    this.durationMs,
    this.waveform,
    required this.timestamp,
  });

  factory StudyRoomMessage.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return StudyRoomMessage(
      id: doc.id,
      senderId: d['sender_id'] as String,
      senderName: (d['sender_name'] as String?)?.trim().isNotEmpty == true
          ? d['sender_name'] as String
          : 'Student',
      type: StudyRoomMessageType.values.firstWhere((t) => t.name == d['type']),
      content: d['content'] as String,
      fileName: d['file_name'] as String?,
      durationMs: d['duration_ms'] as int?,
      waveform: (d['waveform'] as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList(),
      timestamp: (d['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

// ── Service ──────────────────────────────────────────────────────────────

class StudyRoomService {
  StudyRoomService._();
  static final instance = StudyRoomService._();

  final _db = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  // Set this once the Cloudflare Worker (presigned R2 upload minting) is
  // deployed. Leaving it null is deliberate -- calling an attachment method
  // before then should fail loudly, not point at a placeholder domain that
  // looks real but silently 404s.
  static const String? studyChatWorkerUrl = 'https://edul-study-chat.edulinkore.workers.dev';

  String get _uid {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw StateError('No signed-in user.');
    return uid;
  }

  CollectionReference<Map<String, dynamic>> get _rooms => _db.collection('study_rooms');

  // ── Room lifecycle ────────────────────────────────────────────────────

  /// Creates a room and adds the host as its first participant. These are
  /// two separate writes (not a single transaction) because they hit two
  /// different security-rule paths -- the room create rule requires
  /// participant_count == 1 up front, then the participant subdoc is
  /// created against that already-committed room.
  Future<String> createRoom({
    required String title,
    String? courseTag,
    required int maxParticipants,
    required int durationMinutes,
    required String hostDisplayName,
  }) async {
    final now = DateTime.now();
    final end = now.add(Duration(minutes: durationMinutes));
    final roomRef = _rooms.doc();

    await roomRef.set({
      'title': title,
      'host_id': _uid,
      'course_tag': courseTag,
      'max_participants': maxParticipants,
      'participant_count': 1,
      'duration_minutes': durationMinutes,
      'start_timestamp': FieldValue.serverTimestamp(),
      'end_timestamp': Timestamp.fromDate(end),
      'status': 'active',
    });

    await roomRef.collection('participants').doc(_uid).set({
      'display_name': hostDisplayName,
      'joined_at': FieldValue.serverTimestamp(),
    });

    return roomRef.id;
  }

  /// Browsable list of open rooms, most recent first. Full rooms are
  /// included (not filtered out) so the UI can show a "Full" badge rather
  /// than making rooms disappear the moment they fill up.
  Stream<List<StudyRoom>> activeRoomsStream({String? courseTag}) {
    Query<Map<String, dynamic>> q = _rooms
        .where('status', isEqualTo: 'active')
        .orderBy('start_timestamp', descending: true);
    if (courseTag != null) {
      q = q.where('course_tag', isEqualTo: courseTag);
    }
    return q.snapshots().map((s) => s.docs.map(StudyRoom.fromDoc).toList());
  }

  Stream<StudyRoom> roomStream(String roomId) {
    return _rooms.doc(roomId).snapshots().map(StudyRoom.fromDoc);
  }

  Stream<List<StudyRoomParticipant>> participantsStream(String roomId) {
    return _rooms
        .doc(roomId)
        .collection('participants')
        .orderBy('joined_at')
        .snapshots()
        .map((s) => s.docs.map(StudyRoomParticipant.fromDoc).toList());
  }

  /// Joins a room. Throws if it's full, expired, or already at capacity --
  /// the security rules enforce the same checks server-side, so this is a
  /// fast client-side pre-check for a responsive UI, not the real gate.
  Future<void> joinRoom(String roomId, {required String displayName}) async {
    final roomRef = _rooms.doc(roomId);
    final participantRef = roomRef.collection('participants').doc(_uid);

    final existing = await participantRef.get();
    if (existing.exists) return; // already in -- idempotent for invite links

    final snap = await roomRef.get();
    final room = StudyRoom.fromDoc(snap);
    if (room.status != 'active' || room.isExpiredNow) {
      throw StateError('This room has ended.');
    }
    if (room.isFull) {
      throw StateError('This room is full.');
    }

    await participantRef.set({
      'display_name': displayName,
      'joined_at': FieldValue.serverTimestamp(),
    });
    await roomRef.update({'participant_count': FieldValue.increment(1)});
  }

  Future<void> leaveRoom(String roomId) async {
    final roomRef = _rooms.doc(roomId);
    await roomRef.collection('participants').doc(_uid).delete();
    await roomRef.update({'participant_count': FieldValue.increment(-1)});
  }

  /// Client-side nudge to flip a room to 'expired' once its time is up.
  /// Harmless to call redundantly -- the cron sweep on the upload-tool
  /// server does this too as the source of truth for cleanup, this just
  /// makes the UI/browse-list reflect it immediately for whoever's looking.
  Future<void> markExpiredIfPast(StudyRoom room) async {
    if (room.status == 'active' && room.isExpiredNow) {
      await _rooms.doc(room.id).update({'status': 'expired'});
    }
  }

  // ── Messages ─────────────────────────────────────────────────────────

  Stream<List<StudyRoomMessage>> messagesStream(String roomId) {
    return _rooms
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((s) => s.docs.map(StudyRoomMessage.fromDoc).toList());
  }

  // Denormalized onto every message at write time so the chat can show
  // "who said this" without a lookup per message -- the participants
  // subcollection is the source of truth for who's currently in the room,
  // this is just a cheap display copy.
  String get _senderDisplayName {
    final name = FirebaseAuth.instance.currentUser?.displayName?.trim();
    return (name != null && name.isNotEmpty) ? name : 'Student';
  }

  Future<void> sendTextMessage(String roomId, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || trimmed.length > 2000) return;
    await _rooms.doc(roomId).collection('messages').add({
      'sender_id': _uid,
      'sender_name': _senderDisplayName,
      'type': 'text',
      'content': trimmed,
      'file_name': null,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendImageMessage(String roomId, File file) async {
    final url = await _uploadAttachment(roomId, file, contentType: 'image/jpeg');
    await _rooms.doc(roomId).collection('messages').add({
      'sender_id': _uid,
      'sender_name': _senderDisplayName,
      'type': 'image',
      'content': url,
      'file_name': file.uri.pathSegments.last,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendPdfMessage(String roomId, File file) async {
    final url = await _uploadAttachment(roomId, file, contentType: 'application/pdf');
    await _rooms.doc(roomId).collection('messages').add({
      'sender_id': _uid,
      'sender_name': _senderDisplayName,
      'type': 'pdf',
      'content': url,
      'file_name': file.uri.pathSegments.last,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// Voice note recording itself is handled by VoiceNoteService (same
  /// recorder used for social feed comments) -- this just uploads the
  /// resulting file through study-chat's own presigned Worker flow
  /// (instead of the general post-upload Worker) and writes the message.
  Future<void> sendVoiceMessage(String roomId, File file, {
    required int durationMs,
    required List<double> waveform,
  }) async {
    final url = await _uploadAttachment(roomId, file, contentType: 'audio/m4a');
    await _rooms.doc(roomId).collection('messages').add({
      'sender_id': _uid,
      'sender_name': _senderDisplayName,
      'type': 'voice',
      'content': url,
      'file_name': null,
      'duration_ms': durationMs,
      'waveform': waveform,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// Two-step upload: ask the Worker for a presigned PUT URL scoped to
  /// study-chat/{roomId}/{uuid}, then PUT the file bytes straight to R2.
  /// The file never passes through our own server.
  Future<String> _uploadAttachment(String roomId, File file, {required String contentType}) async {
    if (studyChatWorkerUrl == null) {
      throw StateError(
        'Study chat attachment uploads are not configured yet -- '
        'set StudyRoomService.studyChatWorkerUrl once the Cloudflare Worker is deployed.',
      );
    }
    final key = 'study-chat/$roomId/${_uuid.v4()}';
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) {
      throw StateError('You need to be signed in to share files in a study room.');
    }
    final presignRes = await http.post(
      Uri.parse('$studyChatWorkerUrl/presign'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: '{"key":"$key","contentType":"$contentType"}',
    );
    if (presignRes.statusCode != 200) {
      throw Exception('Failed to get upload URL: ${presignRes.body}');
    }
    final uploadUrl = RegExp(r'"uploadUrl":"([^"]+)"').firstMatch(presignRes.body)?.group(1);
    final publicUrl = RegExp(r'"publicUrl":"([^"]+)"').firstMatch(presignRes.body)?.group(1);
    if (uploadUrl == null || publicUrl == null) {
      throw Exception('Malformed presign response: ${presignRes.body}');
    }

    final bytes = await file.readAsBytes();
    final putRes = await http.put(
      Uri.parse(uploadUrl),
      headers: {'Content-Type': contentType},
      body: bytes,
    );
    if (putRes.statusCode != 200) {
      throw Exception('Upload to R2 failed: ${putRes.statusCode} -- ${putRes.body}');
    }
    return publicUrl;
  }

  // ── Reporting ────────────────────────────────────────────────────────

  Future<void> reportParticipant({
    required String roomId,
    required String reportedUserId,
    required String reason,
  }) async {
    await _rooms.doc(roomId).collection('reports').add({
      'reporter_id': _uid,
      'reported_user_id': reportedUserId,
      'reason': reason.trim().substring(0, reason.trim().length.clamp(0, 300)),
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Mirror the badge_eligible admin-notification pattern so reports show
    // up live for review instead of requiring a manual Firestore check.
    await _db.collection('notifications').add({
      'uid': 'oGr2sN8TNlUfjlhmxBiDsT3Q8KF3',
      'type': 'study_room_report',
      'title': 'Study room report',
      'body': 'A user was reported in room $roomId.',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}