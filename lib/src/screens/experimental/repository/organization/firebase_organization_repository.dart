import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:union_app/src/screens/experimental/models/organization.dart';

class FirebaseOrganizationRepository {
  factory FirebaseOrganizationRepository() {
    return _singleton;
  }

  FirebaseOrganizationRepository._internal();

  static final FirebaseOrganizationRepository _singleton = FirebaseOrganizationRepository._internal();

  final CollectionReference<Map<String, dynamic>> firestoreInstance = FirebaseFirestore.instance.collection('organizations');

  final Reference storageReference = FirebaseStorage.instance.ref().child('organization');

  Future<void> saveOrganization(Organization organization) async {
    Organization retOrganization = organization;
    final DocumentReference<Map<String, dynamic>> documentReference = firestoreInstance.doc();

    if (organization.photo != null) {
      late String url;
      final Reference reference = storageReference.child(documentReference.id).child('picture');
      final UploadTask uploadTask = reference.putFile(organization.photo!);
      await uploadTask.then((TaskSnapshot taskSnapshot) async {
        url = await taskSnapshot.ref.getDownloadURL();
      });
      retOrganization = organization.copyWith(photoUrl: url);
    }
    await firestoreInstance.doc(documentReference.id).set(retOrganization.toJson());
  }

  Future<Organization> getOrganizationById(String id) async {
    final Map<String, dynamic>? json = (await firestoreInstance.doc(id).get()).data();
    if (json != null) {
      return Organization.fromJson(json);
    } else {
      return Organization.empty;
    }
  }

  Future<void> updateOrganization(String id, Organization organization) async {
    await firestoreInstance.doc(id).update(organization.toJson());
  }

  Future<List<Organization>> getUserOrganizations(String uid) async {
    return _userOrganizationsFromQuery(await firestoreInstance.where('members', arrayContains: uid).get());
  }

  List<Organization> _userOrganizationsFromQuery(QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return Organization.fromJson(json);
      } else {
        return Organization.empty;
      }
    }).toList()
      ..sort((Organization a, Organization b) => a.name.compareTo(b.name));
  }
}
