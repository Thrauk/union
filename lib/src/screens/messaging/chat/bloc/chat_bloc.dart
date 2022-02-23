import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/chat/chat_message.dart';
import 'package:union_app/src/models/chat/conversation.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/repository/messaging/conversation_repository.dart';
import 'package:union_app/src/repository/messaging/message_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required String myUid, required String partnerUid})
      : _myUid = myUid,
        _partnerUid = partnerUid,
        super(const ChatState()) {
    on<Initialize>(_onInitialize);
    on<CreateChat>(_onCreateChat);
    on<SendMessage>(_onSendMessage);
    on<ChatUpdated>(_onChatUpdated);
    on<StartMessageSubscribe>(_onStartMessageSubscribe);
    on<ComposedMessageChanged>(_onComposedMessageChanged);
    on<ScrollToBottom>(_onScrollToBottom);
    on<ScrollDone>(_onScrollDone);
    add(Initialize());
  }

  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  final MessageRepository _messageRepository = MessageRepository();
  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final String _myUid;
  final String _partnerUid;
  late final StreamSubscription<List<ChatMessage>> _messageSubscription;

  Future<void> _onInitialize(Initialize event, Emitter<ChatState> emit) async {
    final FullUser myUser =
        await _firebaseUserRepository.getFullUserByUid(_myUid);
    final FullUser partnerUser =
        await _firebaseUserRepository.getFullUserByUid(_partnerUid);
    emit(state.copyWith(myUser: myUser, partnerUser: partnerUser));

    final Conversation conversation = await _conversationRepository
        .getConversationBetweenTwoUsers(_myUid, _partnerUid);
    if (conversation != Conversation.empty) {
      emit(state.copyWith(conversation: conversation, existingChat: true));
      add(StartMessageSubscribe());
    } else {
      emit(state.copyWith(loaded: true));
    }
  }

  Future<void> _onCreateChat(CreateChat event, Emitter<ChatState> emit) async {
    emit(state.copyWith(loaded: false));
    final Conversation conversation =
        await _conversationRepository.createConversationBetweenTwoUsers(
            _myUid, _partnerUid, event.chatMessage);
    await _messageRepository.sendMessage(conversation.id, event.chatMessage);
    emit(state.copyWith(conversation: conversation, existingChat: true));
    add(StartMessageSubscribe());
    emit(state.copyWith(loaded: true));
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    if(state.composedMessage != '') {
      final ChatMessage chatMessage = ChatMessage(
          message: state.composedMessage.trim(),
          authorId: _myUid,
          sentTimestamp: DateTime.now().microsecondsSinceEpoch);
      if (state.conversation != Conversation.empty) {
        await _messageRepository.sendMessage(state.conversation.id, chatMessage);
      } else {
        add(CreateChat(chatMessage: chatMessage));
      }
    }
  }

  void _onChatUpdated(ChatUpdated event, Emitter<ChatState> emit) {
    emit(state.copyWith(messages: event.chatMessageList));
  }

  Future<void> _onStartMessageSubscribe(
      StartMessageSubscribe event, Emitter<ChatState> emit) async {
    _messageSubscription = _messageRepository
        .chatMessageStream(state.conversation.id)
        .listen((List<ChatMessage> messages) =>
            add(ChatUpdated(chatMessageList: messages)));
  }

  void _onComposedMessageChanged(ComposedMessageChanged event, Emitter<ChatState> emit) {
    emit(state.copyWith(composedMessage: event.message));
  }

  void _onScrollToBottom(ScrollToBottom event, Emitter<ChatState> emit) {
    emit(state.copyWith(scrollToBottom: true));
  }

  void _onScrollDone(ScrollDone event, Emitter<ChatState> emit) {
    emit(state.copyWith(scrollToBottom: false));
  }

  @override
  Future<void> close() {
    _messageSubscription.cancel();
    return super.close();
  }
}
