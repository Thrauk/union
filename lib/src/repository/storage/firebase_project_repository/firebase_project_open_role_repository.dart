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

  void createProjectOpenRole(ProjectOpenRole projectOpenRole) {
    try {
      final ProjectOpenRole openRoleToSave = projectOpenRole.copyWith(id: firestoreProjectsOpenRolesDocument.id);
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
}
