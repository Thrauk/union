import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/chat/chat_message.dart';
import 'package:union_app/src/repository/messaging/conversation_repository.dart';

class MessageRepository {

  factory MessageRepository() {
    return _singleton;
  }

  MessageRepository._internal();

  static final MessageRepository _singleton = MessageRepository._internal();

  final CollectionReference<Map<String, dynamic>> firestoreInstance = FirebaseFirestore.instance.collection('conversations');

  final ConversationRepository _conversationRepository = ConversationRepository();

  Stream<List<ChatMessage>> chatMessageStream(String conversationId) {
    return firestoreInstance.doc(conversationId).collection('messages').orderBy('sentTimestamp', descending: true).limit(100).snapshots().map(_messageListFromQuery);
  }

  List<ChatMessage> _messageListFromQuery(QuerySnapshot<Map<String,dynamic>> query) {

    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String,dynamic> chatMessageJson = documentSnapshot.data();
      if(chatMessageJson != null) {
        return ChatMessage.fromJson(chatMessageJson);
      } else {
        return ChatMessage.empty;
      }
    }).toList();

  }

  Future<void> sendMessage(String conversationId, ChatMessage messageToSend) async {
    final CollectionReference<Map<String, dynamic>> collectionReference = firestoreInstance.doc(conversationId).collection('messages');
    final DocumentReference<Map<String, dynamic>> documentReference = collectionReference.doc();
    await documentReference.set(messageToSend.toJson());
    await _conversationRepository.setLastMessage(conversationId, messageToSend);
  }



}
