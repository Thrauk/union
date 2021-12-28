import 'dart:core';

import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  const ChatMessage(
      {
      required this.message,
      required this.authorId,
      required this.sentTimestamp,
      this.readTimestamp});

  ChatMessage.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String,
        authorId = json['authorId'] as String,
        sentTimestamp = json['sentTimestamp'] as int,
        readTimestamp = json['readTimestamp'] as int?;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
        'authorId': authorId,
        'sentTimestamp': sentTimestamp,
        'readTimestamp': readTimestamp,
      }..removeWhere((String key, dynamic value) => value == null);

  ChatMessage copyWith({
    String? conversationId,
    String? message,
    String? authorId,
    int? sentTimestamp,
    int? readTimestamp,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      authorId: authorId ?? this.authorId,
      sentTimestamp: sentTimestamp ?? this.sentTimestamp,
      readTimestamp: readTimestamp ?? this.readTimestamp,
    );
  }

  static const ChatMessage empty = ChatMessage( message: '', authorId: '', sentTimestamp: 0);

  final String message;
  final String authorId;
  final int sentTimestamp;
  final int? readTimestamp;

  @override
  List<Object?> get props => <Object?>[
        message,
        authorId,
        sentTimestamp,
        readTimestamp
      ];
}
