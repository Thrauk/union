import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseProjectOpenRoleRepository {
  final CollectionReference<Map<String, dynamic>> firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final DocumentReference<Map<String, dynamic>>
      firestoreProjectsOpenRolesDocument =
      FirebaseFirestore.instance.collection('projects_open_roles').doc();

  final CollectionReference<Map<String, dynamic>>
      firestoreProjectsOpenRolesCollection =
      FirebaseFirestore.instance.collection('projects_open_roles');

  final CollectionReference<Map<String, dynamic>>
      firestoreProjectsAppliesCollection =
      FirebaseFirestore.instance.collection('projects_applies');

  final CollectionReference<Map<String, dynamic>> firestoreUsersCollection =
      FirebaseFirestore.instance.collection('users');

  void createProjectOpenRole(ProjectOpenRole projectOpenRole) {
    try {
      final ProjectOpenRole openRoleToSave =
          projectOpenRole.copyWith(id: firestoreProjectsOpenRolesDocument.id);
      print('project open role ${openRoleToSave.toJson()}');
      firestoreProjectsOpenRolesDocument.set(openRoleToSave.toJson());
      firestoreProjectsCollection.doc(projectOpenRole.projectId).update({
        'open_roles':
            FieldValue.arrayUnion([firestoreProjectsOpenRolesDocument.id])
      });
    } catch (e) {
      print('createProjectOpenRole $e');
    }
  }

  Future<List<ProjectOpenRole>> getOpenRolesByProjectId(
      String projectId) async {
    final List<ProjectOpenRole> openRoles =
        List<ProjectOpenRole>.empty(growable: true);
    final Map<String, dynamic>? openRolesData;
    final List<String> openRolesIds;
    try {
      openRolesData =
          (await firestoreProjectsCollection.doc(projectId).get()).data();
      openRolesIds = (openRolesData!['open_roles'] as List<dynamic>)
          .map((el) => el as String)
          .toList();
      for (final String id in openRolesIds) {
        final ProjectOpenRole? openRole = await getOpenRoleById(id);
        if (openRole != null) {
          openRoles.add(openRole);
        }
      }
    } catch (e) {
      print('getOpenRolesByProjectId $e');
    }
    return openRoles;
  }

  Future<ProjectOpenRole?> getOpenRoleById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> json =
          await firestoreProjectsOpenRolesCollection.doc(id).get();
      final ProjectOpenRole openRole = ProjectOpenRole.fromJson(json.data()!);
      return openRole;
    } catch (e) {
      print('getOpenRoleById $e');
    }
    return null;
  }

  Future<void> changeUidToOpenRole(String uid, String openRoleId) async {
    try {
      final DocumentReference<Map<String, dynamic>> reference =
          firestoreProjectsOpenRolesCollection.doc(openRoleId);
      final Map<String, dynamic>? openRoleJson = (await reference.get()).data();
      if (openRoleJson != null) {
        final ProjectOpenRole openRole = ProjectOpenRole.fromJson(openRoleJson);
        if (!openRole.applicantsUids.contains(uid)) {
          firestoreProjectsAppliesCollection.doc(uid).update({
            'applies': FieldValue.arrayUnion([openRoleId])
          });
          reference.update({
            'applicants_uids': FieldValue.arrayUnion([uid])
          });
        } else {
          // TODO crash if all fields are empty
          firestoreProjectsAppliesCollection.doc(uid).update({
            'applies': FieldValue.arrayRemove([openRoleId])
          });
          reference.update({
            'applicants_uids': FieldValue.arrayRemove([uid])
          });
        }
      }
    } catch (e) {
      print('changeUidToOpenRole $e');
    }
  }

  Future<bool?> isUidAlreadyAdded(String uid, String openRoleId) async {
    try {
      final DocumentReference<Map<String, dynamic>> reference =
          firestoreProjectsOpenRolesCollection.doc(openRoleId);
      final Map<String, dynamic>? openRoleJson = (await reference.get()).data();
      if (openRoleJson != null) {
        final ProjectOpenRole openRole = ProjectOpenRole.fromJson(openRoleJson);
        print('changeUidToOpenRole ${openRole.applicantsUids} $uid');
        if (openRole.applicantsUids.contains(uid)) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print('changeUidToOpenRole $e');
    }
    return null;
  }

  Future<List<FullUser>> getFullUsersListByOpenRole(String openRoleId) async {
    final List<FullUser> userList = <FullUser>[];
    try {
      final Map<String, dynamic>? openRoleApplies =
          (await firestoreProjectsOpenRolesCollection.doc(openRoleId).get())
              .data();
      final List<dynamic> usersUids =
          openRoleApplies!['applicants_uids'] as List<dynamic>;
      for (final dynamic uid in usersUids) {
        final Map<String, dynamic>? userJson =
            (await firestoreUsersCollection.doc(uid as String).get()).data();
        userList.add(FullUser.fromJson(userJson!));
      }
    } catch (e) {
      print('getFullUsersListByOpenRole $e');
    }
    return userList;
  }
}
