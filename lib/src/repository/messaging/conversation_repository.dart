import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/chat/chat_message.dart';
import 'package:union_app/src/models/chat/conversation.dart';

class ConversationRepository {
  factory ConversationRepository() {
    return _singleton;
  }

  ConversationRepository._internal();

  static final ConversationRepository _singleton =
      ConversationRepository._internal();

  final CollectionReference<Map<String, dynamic>> firestoreInstance =
      FirebaseFirestore.instance.collection('conversations');

  Stream<List<Conversation>> userConversationStream(String userId) {
    return firestoreInstance
        .where('members', arrayContains: userId)
        .snapshots()
        .map(_userConversationsFromQuery);
  }

  List<Conversation> _userConversationsFromQuery(
      QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs
        .toList()
        .map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return Conversation.fromJson(json);
      } else {
        return Conversation.empty;
      }
    }).toList()..sort((a, b) => b.lastReceivedTimestamp!.compareTo(a.lastReceivedTimestamp ?? 0));
  }

  Stream<Conversation> conversationStream(String id) {
    return firestoreInstance.doc(id).snapshots().map(_conversationFromSnapshot);
  }

  Conversation _conversationFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? json = snapshot.data();
    if (json != null) {
      return Conversation.fromJson(json);
    } else {
      return Conversation.empty;
    }
  }

  Future<void> setLastMessage(
      String conversationId, ChatMessage message) async {
    firestoreInstance.doc(conversationId).update(
      <String, dynamic>{'lastMessage': message.toJson(), 'lastReceivedTimestamp': message.sentTimestamp},
    );
  }

  Future<Conversation> createConversationBetweenTwoUsers(
      String uidUser1, String uidUser2, ChatMessage message) async {
    final DocumentReference<Map<String, dynamic>> documentReference =
        firestoreInstance.doc();
    final Conversation conversation = Conversation(
        id: documentReference.id,
        members: <String>[uidUser1, uidUser2],
        );
    await documentReference.set(conversation.toJson());
    return conversation;
  }

  Future<Conversation> getConversationBetweenTwoUsers(String userId1, String userId2) async {
    final QuerySnapshot<Map<String,dynamic>> querySnapshot = await firestoreInstance
        .where('members', arrayContains: userId1)
        .get();



    final QueryDocumentSnapshot<Map<String,dynamic>> json = querySnapshot.docs.where((QueryDocumentSnapshot<Map<String, dynamic>> element) {
      if(element.data()['members'] != null) {
        final List<dynamic> membersDynamic = element.data()['members'] as List<dynamic>;
        final List<String> members = membersDynamic.cast<String>();
        if(members.contains(userId2)) {
          return true;
        }
      } return false;
    }).first;

    if(json != null) {
      return Conversation.fromJson(json.data());
    } else {
      return Conversation.empty;
    }
  }
}
