// lib/features/tutor/domain/models/message_model.dart
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TutorMessage extends Equatable {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final int? xpEarned;
  final String? error;

  const TutorMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.xpEarned,
    this.error,
  });

  @override
  List<Object?> get props => [id, content, isUser, timestamp, xpEarned, error];

  TutorMessage copyWith({
    String? id,
    String? content,
    bool? isUser,
    DateTime? timestamp,
    int? xpEarned,
    String? error,
  }) {
    return TutorMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      xpEarned: xpEarned ?? this.xpEarned,
      error: error ?? this.error,
    );
  }

  bool get hasError => error != null && error!.isNotEmpty;

  Map<String, dynamic> toMap() => {
    'content': content,
    'isUser': isUser,
    'timestamp': Timestamp.fromDate(timestamp),
    if (xpEarned != null) 'xpEarned': xpEarned,
  };

  factory TutorMessage.fromMap(String id, Map<String, dynamic> map) => TutorMessage(
    id: id,
    content: map['content'] as String? ?? '',
    isUser: map['isUser'] as bool? ?? false,
    timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    xpEarned: map['xpEarned'] as int?,
  );
}