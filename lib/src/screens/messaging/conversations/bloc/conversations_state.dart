part of 'conversations_bloc.dart';

@immutable
class ConversationsState extends Equatable{
  const ConversationsState({
    this.conversations = const <Conversation>[],
    this.loaded = false,
  });

  final List<Conversation> conversations;
  final bool loaded;

  ConversationsState copyWith({
    List<Conversation>? conversations,
    bool? loaded,
  }) {
    return ConversationsState(
      conversations: conversations ?? this.conversations,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  List<Object?> get props => <Object?>[conversations, loaded];

}
