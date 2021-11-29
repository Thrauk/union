import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseProjectRepository {
  final DocumentReference<Map<String, dynamic>> firestoreInstance =
      FirebaseFirestore.instance.collection('projects').doc();

  void createProject(Project project) {
    final Project projectToSave = project.copyWith(id: firestoreInstance.id);
    firestoreInstance.set(projectToSave.toJson());
  }
}
