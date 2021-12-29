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
    this.scrollToBottom = false,
  });

  final bool existingChat;
  final bool loaded;
  final List<ChatMessage> messages;
  final FullUser myUser;
  final FullUser partnerUser;
  final Conversation conversation;
  final String composedMessage;
  final bool scrollToBottom;

  ChatState copyWith({
    bool? existingChat,
    List<ChatMessage>? messages,
    FullUser? myUser,
    FullUser? partnerUser,
    Conversation? conversation,
    bool? loaded,
    String? composedMessage,
    bool? scrollToBottom,
  }) {
    return ChatState(
      existingChat: existingChat ?? this.existingChat,
      messages: messages ?? this.messages,
      myUser: myUser ?? this.myUser,
      partnerUser: partnerUser ?? this.partnerUser,
      conversation: conversation ?? this.conversation,
      loaded: loaded ?? this.loaded,
      composedMessage: composedMessage ?? this.composedMessage,
      scrollToBottom: scrollToBottom ?? this.scrollToBottom,
    );
  }

  @override
  List<Object?> get props => <Object?>[existingChat, messages, myUser, partnerUser, conversation, loaded, composedMessage, scrollToBottom];
}
