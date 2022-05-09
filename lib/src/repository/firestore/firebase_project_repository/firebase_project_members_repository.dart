import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProjectMembersRepository {
  factory FirebaseProjectMembersRepository() {
    return _singleton;
  }

  FirebaseProjectMembersRepository._internal();

  static final FirebaseProjectMembersRepository _singleton = FirebaseProjectMembersRepository._internal();

  final CollectionReference<Map<String, dynamic>> _firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  void addMemberToProject(String uid, String projectId) {
    _firestoreProjectsCollection.doc(projectId).update({
      'members_uid': FieldValue.arrayUnion([uid])
    });
  }
}
