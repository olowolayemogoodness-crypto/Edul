// lib/core/services/search_history_service.dart
//
// Local, per-device search history for Social search -- deliberately
// NOT synced through Firestore. This is exactly the kind of personal
// convenience data (like a remembered draft or a UI preference) that
// doesn't need a backend round-trip, a security rule, or to sync
// across devices to be useful. SharedPreferences is already a
// dependency in this project (post_composer_page.dart uses it for
// the same "small local thing" reasoning).
//
// Tracks TWO different kinds of history entries, matching how
// Instagram's actual search history works -- not just raw text:
//   'query'   -- a text string that was searched (e.g. "assignment")
//   'profile' -- a specific person whose result was tapped
// Shown together in one recency-ordered list; only the icon differs.
//
// This is also the foundation for the later "see more of someone
// after you've searched them" feature -- that reads from the same
// profile-visit history this writes.

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_service.dart';

class SearchHistoryEntry {
  final String type; // 'query' or 'profile'
  final String value; // the query text, or the profile's uid
  final String? label; // display name, only set for 'profile' entries
  final int timestamp;

  SearchHistoryEntry({
    required this.type,
    required this.value,
    this.label,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
        'label': label,
        'timestamp': timestamp,
      };

  factory SearchHistoryEntry.fromJson(Map<String, dynamic> json) => SearchHistoryEntry(
        type: json['type'] as String,
        value: json['value'] as String,
        label: json['label'] as String?,
        timestamp: json['timestamp'] as int,
      );
}

class SearchHistoryService {
  SearchHistoryService._();

    static const _maxEntries = 20;
  static String get _prefsKey => 'social_search_history_${UserService.uid ?? "anon"}';

  static Future<List<SearchHistoryEntry>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_prefsKey) ?? [];
    return raw
        .map((s) {
          try {
            return SearchHistoryEntry.fromJson(jsonDecode(s) as Map<String, dynamic>);
          } catch (_) {
            return null;
          }
        })
        .whereType<SearchHistoryEntry>()
        .toList();
  }

  static Future<void> _save(List<SearchHistoryEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = entries.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_prefsKey, raw);
  }

  /// Adds an entry, deduplicating by (type, value) -- searching the
  /// same thing twice moves it to the top rather than creating a
  /// second row, same behavior every real app's search history has.
  static Future<void> addEntry({
    required String type,
    required String value,
    String? label,
  }) async {
    if (value.trim().isEmpty) return;
    final existing = await getHistory();
    existing.removeWhere((e) => e.type == type && e.value == value);
    existing.insert(0, SearchHistoryEntry(
      type: type,
      value: value,
      label: label,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    ));
    await _save(existing.take(_maxEntries).toList());
  }

  static Future<void> removeEntry(String type, String value) async {
    final existing = await getHistory();
    existing.removeWhere((e) => e.type == type && e.value == value);
    await _save(existing);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}