part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => <Object>[];
}

class CreateChat extends ChatEvent {
  const CreateChat({required this.chatMessage});

  final ChatMessage chatMessage;
  @override
  List<Object> get props => <Object>[chatMessage];
}

class SendMessage extends ChatEvent {
}

class ChatUpdated extends ChatEvent {
  const ChatUpdated({required this.chatMessageList});

  final List<ChatMessage> chatMessageList;
  @override
  List<Object> get props => <Object>[chatMessageList];
}

class Initialize extends ChatEvent {}

class StartMessageSubscribe extends ChatEvent {}

class ComposedMessageChanged extends ChatEvent {
  const ComposedMessageChanged({required this.message});

  final String message;
  @override
  List<Object> get props => <Object>[message];
}

class ScrollToBottom extends ChatEvent {}

class ScrollDone extends ChatEvent {}
