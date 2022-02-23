import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/models/organization/organization.dart';

class FirebaseOrganizationRepository {
  factory FirebaseOrganizationRepository() {
    return _singleton;
  }

  FirebaseOrganizationRepository._internal();

  static final FirebaseOrganizationRepository _singleton = FirebaseOrganizationRepository._internal();

  final FirebaseProjectRepository _firebaseProjectRepository = FirebaseProjectRepository();

  final CollectionReference<Map<String, dynamic>> firestoreInstance = FirebaseFirestore.instance.collection('organizations');

  final Reference storageReference = FirebaseStorage.instance.ref().child('organization');

  Future<void> saveOrganization(Organization organization) async {
    final DocumentReference<Map<String, dynamic>> documentReference = firestoreInstance.doc();
    Organization retOrganization = organization.copyWith(id: documentReference.id);

    if (organization.photo != null) {
      late String url;
      final Reference reference = storageReference.child(documentReference.id).child('picture');
      final UploadTask uploadTask = reference.putFile(organization.photo!);
      await uploadTask.then((TaskSnapshot taskSnapshot) async {
        url = await taskSnapshot.ref.getDownloadURL();
      });
      retOrganization = retOrganization.copyWith(photoUrl: url);
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

  Future<bool> removeMemberByUid(String organizationId, String memberUid) async {
    try {
      await firestoreInstance.doc(organizationId).update(
        {
          'members': FieldValue.arrayRemove(<String>[memberUid])
        },
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> addMemberByUid(String organizationId, String memberUid) async {
    try {
      await firestoreInstance.doc(organizationId).update(
        {
          'members': FieldValue.arrayUnion(<String>[memberUid])
        },
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<Organization>> getAllOrganizations() async {
    final List<Organization> users = (await firestoreInstance.get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> userJson) => Organization.fromJson(userJson.data()))
        .toList();
    return users;
  }

  Future<bool> joinOrganization(String organizationId, String memberUid) async {
    return addMemberByUid(organizationId, memberUid);
  }

  Future<bool> leaveOrganization(String organizationId, String memberUid) async {
    return removeMemberByUid(organizationId, memberUid);
  }

  Future<void> deleteOrganization(String organizationId) async {
    await firestoreInstance.doc(organizationId).delete();
    final List<Project> projects = await _firebaseProjectRepository.getProjectsOrganization(20, organizationId);
    for (int i = 0; i < projects.length; i++) {
      final Project project = projects[i];
      _firebaseProjectRepository.deleteProject(project);
    }
  }


}
