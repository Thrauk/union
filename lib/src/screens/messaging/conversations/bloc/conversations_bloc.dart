import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/chat/conversation.dart';
import 'package:union_app/src/repository/messaging/conversation_repository.dart';

part 'conversations_event.dart';

part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc({required String uid})
      : _uid = uid,
        super(const ConversationsState()) {
    on<ConversationUpdated>(_onConversationUpdated);

    _conversationSubscription = _conversationRepository.userConversationStream(_uid).listen((List<Conversation> conversations) {
      add(ConversationUpdated(conversationList: conversations));
    });
  }

  final String _uid;
  final ConversationRepository _conversationRepository = ConversationRepository();
  late final StreamSubscription<List<Conversation>> _conversationSubscription;

  void _onConversationUpdated(ConversationUpdated event, Emitter<ConversationsState> emit) {
    emit(state.copyWith(conversations: event.conversationList));
  }

  @override
  Future<void> close() {
    _conversationSubscription.cancel();
    return super.close();
  }
}
