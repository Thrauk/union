import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseUserServiceRepository {
  final CollectionReference<Map<String, dynamic>> firestoreInstance =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserAuthDetails(AppUser user) async {
    firestoreInstance.doc(user.id).set(user.toJson());
  }

  Stream<FullUser> fullUser(String uid) {
    return firestoreInstance.doc(uid).snapshots().map(_profileFromSnapshot);
  }

  FullUser _profileFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? json = snapshot.data();
    if(json != null) {
      return FullUser.fromJson(json);
    } else {
      return const FullUser(id: '');
    }
  }

  Future<FullUser> getUserFullDetails(AppUser user) async {
    final Map<String, dynamic>? json = (await firestoreInstance.doc(user.id).get()).data();
    if(json != null) {
      return FullUser.fromJson(json);
    } else {
      return const FullUser(id: '');
    }
  }

  Future<void> updateUserDetails(FullUser user) async {
    firestoreInstance.doc(user.id).update(user.toJson());
  }

}
