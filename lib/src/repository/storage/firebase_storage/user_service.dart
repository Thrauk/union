import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/authentication/app_user.dart';

class UserService {
  final CollectionReference<Map<String, dynamic>> firestoreInstance =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserAuthDetails(AppUser user) async {
    firestoreInstance.doc(user.id).set(user.toJson());
  }
}
