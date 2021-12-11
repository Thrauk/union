import 'package:cloud_firestore/cloud_firestore.dart';

class FollowService {
  final CollectionReference<Map<String, dynamic>> firestoreUserInstance = FirebaseFirestore.instance.collection('users');


  Future<void> followUser(String myUserUid, String otherUserUid) async {
    firestoreUserInstance.doc(myUserUid).get();
  }




}
