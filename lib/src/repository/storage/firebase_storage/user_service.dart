import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference<Map<String, dynamic>> firestoreInstance = FirebaseFirestore.instance.collection('users');

  Future<void> saveUserAuthDetails() async {

  }
}
