import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePushTokenRepository {
  factory FirebasePushTokenRepository() {
    return _singleton;
  }

  FirebasePushTokenRepository._internal();

  static final FirebasePushTokenRepository _singleton = FirebasePushTokenRepository._internal();

  final CollectionReference<Map<String, dynamic>> firestoreInstance = FirebaseFirestore.instance.collection('push_token');

  Future<void> addPushToken(String uid, String pushToken) async {
    await firestoreInstance.doc(uid).set({
      'push_tokens': pushToken,
    });
  }

  Future<List<String>> getPushTokensByUid(String uid) async {
    final Map<String, dynamic>? jsonResponse = (await firestoreInstance.doc(uid).get()).data();
    if(jsonResponse != null && jsonResponse.containsKey('push_tokens')) {
      return jsonResponse['push_tokens'] as List<String>;
    } else {
      return const <String>[];
    }
  }

}
