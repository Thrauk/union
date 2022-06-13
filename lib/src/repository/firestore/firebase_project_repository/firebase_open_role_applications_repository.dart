import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseOpenRoleApplicationsRepository {
  final CollectionReference<Map<String, dynamic>> _firestoreProjectsApplicationsCollection =
      FirebaseFirestore.instance.collection('projects_applications');

  final CollectionReference<Map<String, dynamic>> _firestoreProjectsOpenRolesCollection =
      FirebaseFirestore.instance.collection('projects_open_roles');

  Future<List<ProjectOpenRole>> getUserApplications(String uid) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> query =
          await _firestoreProjectsApplicationsCollection.where('uid', isEqualTo: uid).get();

      final List<ProjectOpenRoleApplication> applications = _applicationsFromQuery(query);
      final List<String> openRolesIds = applications.map((ProjectOpenRoleApplication e) => e.openRoleId).toList();

      final QuerySnapshot<Map<String, dynamic>> openRolesQuery =
          await _firestoreProjectsOpenRolesCollection.where('id', whereIn: openRolesIds).get();

      return _projectOpenRoleFromQuery(openRolesQuery);
    } catch (e) {
      print('getUserApplications $e');
    }
    return <ProjectOpenRole>[];
  }

  List<ProjectOpenRole> _projectOpenRoleFromQuery(QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return ProjectOpenRole.fromJson(json);
      } else {
        return const ProjectOpenRole();
      }
    }).toList();
  }

  List<ProjectOpenRoleApplication> _applicationsFromQuery(QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return ProjectOpenRoleApplication.fromJson(json);
      } else {
        return ProjectOpenRoleApplication();
      }
    }).toList();
  }
}
