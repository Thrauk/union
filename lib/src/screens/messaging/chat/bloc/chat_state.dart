part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.existingChat = false,
    this.messages = const <ChatMessage>[],
    this.myUser = FullUser.empty,
    this.partnerUser = FullUser.empty,
    this.conversation = Conversation.empty,
    this.loaded = false,
    this.composedMessage = '',
  });

  final bool existingChat;
  final bool loaded;
  final List<ChatMessage> messages;
  final FullUser myUser;
  final FullUser partnerUser;
  final Conversation conversation;
  final String composedMessage;

  ChatState copyWith({
    bool? existingChat,
    List<ChatMessage>? messages,
    FullUser? myUser,
    FullUser? partnerUser,
    Conversation? conversation,
    bool? loaded,
    String? composedMessage,
  }) {
    return ChatState(
      existingChat: existingChat ?? this.existingChat,
      messages: messages ?? this.messages,
      myUser: myUser ?? this.myUser,
      partnerUser: partnerUser ?? this.partnerUser,
      conversation: conversation ?? this.conversation,
      loaded: loaded ?? this.loaded,
      composedMessage: composedMessage ?? this.composedMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[existingChat, messages, myUser, partnerUser, conversation, loaded, composedMessage];
}
