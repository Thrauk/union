import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseProjectRepository {
  final DocumentReference<Map<String, dynamic>> firestoreProjectsDocument =
      FirebaseFirestore.instance.collection('projects').doc();

  final CollectionReference<Map<String, dynamic>> firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final CollectionReference<Map<String, dynamic>> firestoreUserInstance =
      FirebaseFirestore.instance.collection('users');

  void createProject(Project project) {
    final Project projectToSave =
        project.copyWith(id: firestoreProjectsDocument.id);
    firestoreUserInstance.doc(project.ownerId).update({
      'projects_ids': FieldValue.arrayUnion([project.id])
    });
    firestoreProjectsDocument.set(projectToSave.toJson());
  }

  Future<Map<String, String>?> getProjectUserDetails(String ownerId) async {
    try {
      var data = (await firestoreUserInstance.doc(ownerId).get()).data();

      final String ownerName = data!['displayName'] != null ? data['displayName'] as String : '';
      final String ownerPhoto = data['ownerPhoto'] != null?  data['ownerPhoto'] as String : '';
      print('Ownername $ownerName');
      return <String, String>{
        'owner_name': ownerName,
        'owner_photo': ownerPhoto
      };
    } catch (e) {
      print('getProjectUserDetails $e');
    }
    return null;
  }

  Future<Project?> getProjectById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> json =
          await firestoreProjectsCollection.doc(id).get();
      final Project project = Project.fromJson(json.data()!);
      return project;
    } catch (e) {
      print('getProjectsById: ${e.toString()}');
    }
    return null;
  }

  Future<List<Project>> getProjectsByUid(String uid) async {
    final List<Project> projects = List<Project>.empty(growable: true);
    final Map<String, dynamic>? projectsData;
    final List<String> projectsIds;
    try {
      projectsData = (await firestoreUserInstance.doc(uid).get()).data();

      projectsIds = (projectsData!['projects_ids'] as List<dynamic>)
          .map((el) => el as String)
          .toList();
      print(projectsIds);
      for (final String id in projectsIds) {
        final Project? project = await getProjectById(id);
        if (project != null) {
          projects.add(project);
        }
      }
    } catch (e) {
      print('getProjectsByUid $e');
    }
    return projects;
  }
}
