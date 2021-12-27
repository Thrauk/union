import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseProjectOpenRoleRepository {
  final CollectionReference<Map<String, dynamic>> firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  void createProjectOpenRole(ProjectOpenRole projectOpenRole) {
    try {
      firestoreProjectsCollection.doc(projectOpenRole.projectId).update({
        'open_roles': FieldValue.arrayUnion([projectOpenRole.toJson()])
      });
    } catch (e) {
      print('createProjectOpenRole $e');
    }
  }
}
