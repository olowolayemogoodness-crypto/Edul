// lib/core/services/username_service.dart
//
// Usernames are enforced unique by making the username itself (lowercase,
// trimmed) the document ID in a dedicated `usernames` collection --
// Firestore has no native unique-constraint, so "the ID is the value"
// is the standard workaround. Claiming (or changing) a username is one
// atomic transaction: check availability, claim the new one, release
// the old one (if any) -- same "read everything first, then write"
// shape already used for the duel matchmaking queue's claim logic.
//
// Display case is preserved separately (someone can be @GoodnessO even
// though the canonical lookup key is 'goodnesso') -- the doc ID and the
// `username` field on the user's own profile stay lowercase for
// uniqueness/lookup, but a `usernameDisplay` field keeps what they
// actually typed for showing on their profile.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

enum UsernameClaimResult { success, taken, invalid, notSignedIn }

class UsernameService {
  UsernameService._();

  static final _db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> _usernames() => _db.collection('usernames');

  static final RegExp _validPattern = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  static String? validationError(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return null; // don't show an error for an empty field
    if (trimmed.length < 3) return 'Too short — at least 3 characters';
    if (trimmed.length > 20) return 'Too long — 20 characters max';
    if (!_validPattern.hasMatch(trimmed)) return 'Letters, numbers, and underscores only';
    return null;
  }

  static String _normalize(String raw) => raw.trim().toLowerCase();

  /// One-off check, e.g. right before showing a live availability
  /// indicator as someone types. Treats your own current username as
  /// "available" so re-saving the same one you already have doesn't
  /// falsely show as taken.
  static Future<bool> isAvailable(String raw) async {
    if (validationError(raw) != null) return false;
    final normalized = _normalize(raw);
    final uid = UserService.uid;
    final doc = await _usernames().doc(normalized).get();
    if (!doc.exists) return true;
    return doc.data()?['uid'] == uid;
  }

  /// Claims [raw] as the current user's username, releasing whatever
  /// username they had before (if any) in the same transaction -- never
  /// a moment where they have two, or a dangling freed one nobody owns.
  static Future<UsernameClaimResult> claimUsername(String raw) async {
    final uid = UserService.uid;
    if (uid == null) return UsernameClaimResult.notSignedIn;
    if (validationError(raw) != null) return UsernameClaimResult.invalid;
    final normalized = _normalize(raw);

    final newRef = _usernames().doc(normalized);
    final userRef = _db.collection('users').doc(uid);

    try {
      final result = await _db.runTransaction<UsernameClaimResult>((tx) async {
        final newDoc = await tx.get(newRef);
        if (newDoc.exists && newDoc.data()?['uid'] != uid) {
          return UsernameClaimResult.taken;
        }
        final userDoc = await tx.get(userRef);
        final oldUsername = userDoc.data()?['username'] as String?;

        tx.set(newRef, {'uid': uid, 'claimedAt': FieldValue.serverTimestamp()});
        tx.update(userRef, {'username': normalized, 'usernameDisplay': raw.trim()});

        if (oldUsername != null && oldUsername != normalized) {
          tx.delete(_usernames().doc(oldUsername));
        }
        return UsernameClaimResult.success;
      });
      return result;
    } catch (_) {
      return UsernameClaimResult.taken; // conservative fallback on any transaction failure
    }
  }
}