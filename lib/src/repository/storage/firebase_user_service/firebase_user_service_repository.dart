import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseUserServiceRepository {
  final CollectionReference<Map<String, dynamic>> firestoreInstance = FirebaseFirestore.instance.collection('users');

  final Reference storageReference = FirebaseStorage.instance.ref().child('users');

  Future<void> saveUserAuthDetails(AppUser user) async {
    firestoreInstance.doc(user.id).set(user.toJson());
  }

  Stream<FullUser> fullUser(String uid) {
    return firestoreInstance.doc(uid).snapshots().map(_profileFromSnapshot);
  }

  FullUser _profileFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? json = snapshot.data();
    if (json != null) {
      return FullUser.fromJson(json);
    } else {
      return const FullUser(id: '');
    }
  }

  Future<FullUser> getUserFullDetails(AppUser user) async {
    final Map<String, dynamic>? json = (await firestoreInstance.doc(user.id).get()).data();
    if (json != null) {
      return FullUser.fromJson(json);
    } else {
      return const FullUser(id: '');
    }
  }

  Future<FullUser> getFullUserByUid(String uid) async {
    final Map<String, dynamic>? json = (await firestoreInstance.doc(uid).get()).data();
    if (json != null) {
      return FullUser.fromJson(json);
    } else {
      return const FullUser(id: '');
    }
  }

  Future<void> updateUserDetails(FullUser user) async {
    await firestoreInstance.doc(user.id).update(user.toJson());
  }

  Future<String> updateUserImage(FullUser user, File image) async {
    late String url;
    final Reference reference = storageReference.child(user.id).child('avatar');
    final UploadTask uploadTask = reference.putFile(image);
    await uploadTask.then((TaskSnapshot taskSnapshot) async {
      url = await taskSnapshot.ref.getDownloadURL();
    });
    await updateUserDetails(user.copyWith(photo: url));
    return url;
  }
}
