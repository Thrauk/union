import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_user/barrel.dart';

class FirebaseProjectMembersRepository {
  factory FirebaseProjectMembersRepository() {
    return _singleton;
  }

  FirebaseProjectMembersRepository._internal();

  static final FirebaseProjectMembersRepository _singleton = FirebaseProjectMembersRepository._internal();

  final CollectionReference<Map<String, dynamic>> _firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final FirebaseUserRepository _userRepository = FirebaseUserRepository();

  void addMemberToProject(String uid, String projectId) {
    _firestoreProjectsCollection.doc(projectId).update({
      'members_uid': FieldValue.arrayUnion([uid])
    });
  }

  void deleteMemberFromProject(String userId, String projectId) {
    _firestoreProjectsCollection.doc(projectId).update({
      'members_uid': FieldValue.arrayRemove(<String>[userId])
    });
  }

  Future<List<FullUser>> getMembers(String projectId) async {
    final List<FullUser> users = List<FullUser>.empty(growable: true);
    final Map<String, dynamic>? projectData;
    final List<String> usersIds;
    try {
      projectData = (await _firestoreProjectsCollection.doc(projectId).get()).data();

      usersIds = (projectData!['members_uid'] as List<dynamic>).map((el) => el as String).toList();

      for (final String id in usersIds) {
        final FullUser user = await _userRepository.getFullUserByUid(id);
        if (user != null) {
          users.add(user);
        }
      }
    } catch (e) {
      print('getMembers $e');
    }
    return users;
  }
}
