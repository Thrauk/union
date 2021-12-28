import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/chat/chat_message.dart';

class Conversation extends Equatable {
  const Conversation({
    required this.id,
    required this.members,
    this.lastReceivedTimestamp,
    this.lastMessage
  });

  Conversation.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        members = json['members'] as List<String>,
        lastReceivedTimestamp = json['lastReceivedTimestamp'] as int,
        lastMessage = ChatMessage.fromJson(json['readTimestamp'] as Map<String,dynamic>);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'members': members,
    'lastReceivedTimestamp': lastReceivedTimestamp,
    'lastMessage': lastMessage,
  }..removeWhere((String key, dynamic value) => value == null);

  Conversation copyWith({
    String? id,
    List<String>? members,
    int? lastReceivedTimestamp,
    ChatMessage? lastMessage,
  }) {
    return Conversation(
      id: id ?? this.id,
      members: members ?? this.members,
      lastReceivedTimestamp: lastReceivedTimestamp ?? this.lastReceivedTimestamp,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  static Conversation get empty => const Conversation(id: '', members: <String>[]);

  final String id;
  final List<String> members;
  final int? lastReceivedTimestamp;
  final ChatMessage? lastMessage;


  @override
  List<Object?> get props => <Object?>[id, members, lastReceivedTimestamp, lastMessage];



}
