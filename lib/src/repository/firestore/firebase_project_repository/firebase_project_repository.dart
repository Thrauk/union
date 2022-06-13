import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseProjectRepository {
  final DocumentReference<Map<String, dynamic>> _firestoreProjectsDocument =
      FirebaseFirestore.instance.collection('projects').doc();

  final CollectionReference<Map<String, dynamic>> _firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final CollectionReference<Map<String, dynamic>> _firestoreUserInstance = FirebaseFirestore.instance.collection('users');

  void createProject(Project project) {
    final Project projectToSave = project.copyWith(id: _firestoreProjectsDocument.id);
    _firestoreProjectsDocument.set(projectToSave.toJson());
  }

  void updateProject(Project project) {
    _firestoreProjectsCollection.doc(project.id).update(project.toJson());
  }

  void deleteProject(Project project) {
    try {
      // TODO(Theodor): cloud function for deleting invites, articles, open roles & likes
      _firestoreProjectsCollection.doc(project.id).delete();
    } catch (e) {
      print('deleteProject $e');
    }
  }

  Future<Map<String, String>?> getProjectUserDetails(String ownerId) async {
    try {
      final Map<String, dynamic>? data = (await _firestoreUserInstance.doc(ownerId).get()).data();

      final String ownerName = data!['displayName'] != null ? data['displayName'] as String : '';
      final String ownerPhoto = data['photo'] != null ? data['photo'] as String : '';
      return <String, String>{'owner_name': ownerName, 'owner_photo': ownerPhoto};
    } catch (e) {
      print('getProjectUserDetails $e');
    }
    return null;
  }

  Future<Project> getProjectById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> json = await _firestoreProjectsCollection.doc(id).get();
      final Project project = Project.fromJson(json.data()!);
      return project;
    } catch (e) {
      print('getProjectById: ${e.toString()}');
    }
    return Project.empty;
  }

  Future<List<Project>> getOwnedProjectsByUid(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> query = await _firestoreProjectsCollection.where('owner_id', isEqualTo: uid).get();
    return _userProjectFromQuery(query);
  }

  Future<List<Project>> getJoinedProjectsByUid(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> query =
        await _firestoreProjectsCollection.where('members_uid', arrayContains: uid).where('owner_id', isNotEqualTo: uid).get();
    return _userProjectFromQuery(query);
  }

  List<Project> _userProjectFromQuery(QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return Project.fromJson(json);
      } else {
        return Project.empty;
      }
    }).toList()
      ..sort((Project a, Project b) => a.title!.compareTo(b.title ?? ''));
  }

  Future<List<Project>> getProjects(int limit) async {
    try {
      final List<Project> projects =
          (await _firestoreProjectsCollection.orderBy('timestamp', descending: true).limit(limit).get())
              .docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => Project.fromJson(e.data()))
              .toList();
      return projects;
    } catch (e) {
      print('getProjects $e');
    }
    return <Project>[];
  }

  Future<List<Project>> getProjectsOrganization(int limit, String organizationId) async {
    try {
      final List<Project> projects =
          (await _firestoreProjectsCollection.where('organization_id', isEqualTo: organizationId).get())
              .docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => Project.fromJson(e.data()))
              .toList();
      return projects;
    } catch (e) {
      print('getProjects $e');
    }
    return <Project>[];
  }

  // DEMO FUNCTION, SHOULD NOT BE USED OTHERWISE
  Future<List<Project>> getAllProjects() async {
    final List<Project> projects = (await _firestoreProjectsCollection.get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> projectJson) => Project.fromJson(projectJson.data()))
        .toList();
    return projects;
  }

  Future<List<Project>> getProjectsByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return <Project>[];
    }
    final QuerySnapshot<Map<String, dynamic>> projectsQuery = await _firestoreProjectsCollection.where('id', whereIn: ids).get();
    return _projectFromQuery(projectsQuery);
  }

  List<Project> _projectFromQuery(QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return Project.fromJson(json);
      } else {
        return Project.empty;
      }
    }).toList();
  }
}
