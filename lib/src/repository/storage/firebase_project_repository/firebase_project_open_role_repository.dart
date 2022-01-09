import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/project_open_role_application.dart';
import 'package:union_app/src/models/project_open_role_application_item.dart';

class FirebaseProjectOpenRoleRepository {
  final CollectionReference<Map<String, dynamic>> firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final DocumentReference<Map<String, dynamic>> firestoreProjectsOpenRolesDocument =
      FirebaseFirestore.instance.collection('projects_open_roles').doc();

  final CollectionReference<Map<String, dynamic>> firestoreProjectsOpenRolesCollection =
      FirebaseFirestore.instance.collection('projects_open_roles');

  final CollectionReference<Map<String, dynamic>> firestoreProjectsApplicationsCollection =
      FirebaseFirestore.instance.collection('projects_applications');

  final CollectionReference<Map<String, dynamic>> firestoreUsersCollection = FirebaseFirestore.instance.collection('users');

  void createProjectOpenRole(ProjectOpenRole projectOpenRole) {
    try {
      final ProjectOpenRole openRoleToSave = projectOpenRole.copyWith(id: firestoreProjectsOpenRolesDocument.id);
      print('project open role ${openRoleToSave.toJson()}');
      firestoreProjectsOpenRolesDocument.set(openRoleToSave.toJson());
      firestoreProjectsCollection.doc(projectOpenRole.projectId).update({
        'open_roles': FieldValue.arrayUnion([firestoreProjectsOpenRolesDocument.id])
      });
    } catch (e) {
      print('createProjectOpenRole $e');
    }
  }

  Future<List<ProjectOpenRole>> getOpenRolesByProjectId(String projectId) async {
    final List<ProjectOpenRole> openRoles = List<ProjectOpenRole>.empty(growable: true);
    final Map<String, dynamic>? openRolesData;
    final List<String> openRolesIds;
    try {
      openRolesData = (await firestoreProjectsCollection.doc(projectId).get()).data();
      openRolesIds = (openRolesData!['open_roles'] as List<dynamic>).map((el) => el as String).toList();
      for (final String id in openRolesIds) {
        final ProjectOpenRole? openRole = await _getOpenRoleById(id);
        if (openRole != null) {
          openRoles.add(openRole);
        }
      }
    } catch (e) {
      print('getOpenRolesByProjectId $e');
    }
    return openRoles;
  }

  Future<ProjectOpenRole?> _getOpenRoleById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> json = await firestoreProjectsOpenRolesCollection.doc(id).get();
      final ProjectOpenRole openRole = ProjectOpenRole.fromJson(json.data()!);
      return openRole;
    } catch (e) {
      print('getOpenRoleById $e');
    }
    return null;
  }

  Future<void> addOrRemoveUidFromOpenRole(ProjectOpenRoleApplication roleApplication, String openRoleId) async {
    try {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> maybeApplicationQuery =
          (await firestoreProjectsApplicationsCollection
                  .where('open_role_id', isEqualTo: openRoleId)
                  .where('uid', isEqualTo: roleApplication.uid)
                  .get())
              .docs;

      if (maybeApplicationQuery.isNotEmpty) {
        print('NOT EMPTY ');
        for (final QueryDocumentSnapshot<Map<String, dynamic>> element in maybeApplicationQuery) {
          firestoreProjectsApplicationsCollection.doc(element.id).delete();
        }
      } else {
        final applicationToSave = roleApplication.copyWith(openRoleId: openRoleId);
        firestoreProjectsApplicationsCollection.doc().set(applicationToSave.toJson());
      }
    } catch (e) {
      print('addOrRemoveUidFromOpenRole $e');
    }
  }

  Future<List<ProjectOpenRoleApplication>> _getProjectApplications(String openRoleId) async {
    try {
      final Query<Map<String, dynamic>> reference =
          firestoreProjectsApplicationsCollection.where('open_role_id', isEqualTo: openRoleId);

      final List<QueryDocumentSnapshot<Map<String, dynamic>>> applicationsListQuery = (await reference.get()).docs.toList();

      return applicationsListQuery.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
        final Map<String, dynamic> json = e.data();
        if (json != null) {
          return ProjectOpenRoleApplication.fromJson(json);
        } else {
          return const ProjectOpenRoleApplication();
        }
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProjectOpenRoleApplicationItem>> getProjectApplicationItems(String openRoleId) async {
    try {
      final List<ProjectOpenRoleApplicationItem> applicationsListItems = <ProjectOpenRoleApplicationItem>[];

      final List<ProjectOpenRoleApplication> applicationsList = await _getProjectApplications(openRoleId);

      for (final ProjectOpenRoleApplication application in applicationsList) {
        final Map<String, dynamic>? userJson = (await firestoreUsersCollection.doc(application.uid).get()).data();
        if (userJson != null) {
          final FullUser user = FullUser.fromJson(userJson);
          applicationsListItems.add(ProjectOpenRoleApplicationItem(application.notice, user));
        }
      }
      return applicationsListItems;
    } catch (e) {
      print(' getProjectApplicationItems $e');
    }
    return [];
  }

  Future<bool?> isUidAlreadyAdded(String uid, String openRoleId) async {
    try {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> maybeApplicationQuery =
          (await firestoreProjectsApplicationsCollection
                  .where('uid', isEqualTo: uid)
                  .where('open_role_id', isEqualTo: openRoleId)
                  .get())
              .docs;

      if (maybeApplicationQuery.isEmpty)
        return false;
      else
        return true;
    } catch (e) {
      print('isUidAlreadyAdded $e');
    }
  }
}
