part of 'conversations_bloc.dart';

@immutable
abstract class ConversationsEvent extends Equatable{
  const ConversationsEvent();

  @override
  List<Object> get props => <Object>[];
}

class ConversationUpdated extends ConversationsEvent {
  const ConversationUpdated({required this.conversationList});

  final List<Conversation> conversationList;
  @override
  List<Object> get props => <Object>[conversationList];
}