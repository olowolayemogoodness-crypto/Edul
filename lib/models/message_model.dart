// lib/features/tutor/domain/models/message_model.dart
import 'package:equatable/equatable.dart';

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

  /// Create a copy with modifications
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

  /// Check if message has error
  bool get hasError => error != null && error!.isNotEmpty;
}