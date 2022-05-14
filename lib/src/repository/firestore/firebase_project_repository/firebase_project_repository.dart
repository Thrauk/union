import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';

import '../firestore.dart';

class FirebaseProjectRepository {
  final DocumentReference<Map<String, dynamic>> firestoreProjectsDocument =
      FirebaseFirestore.instance.collection('projects').doc();

  final CollectionReference<Map<String, dynamic>> firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final FirebaseProjectOpenRoleRepository _firebaseProjectOpenRoleRepository = FirebaseProjectOpenRoleRepository();

  final CollectionReference<Map<String, dynamic>> firestoreUserInstance = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository userRepository = FirebaseUserRepository();
  FirebaseArticleRepository articleRepository = FirebaseArticleRepository();

  void createProject(Project project) {
    final Project projectToSave = project.copyWith(id: firestoreProjectsDocument.id);
    firestoreProjectsDocument.set(projectToSave.toJson());
  }

  void updateProject(Project project) {
    firestoreProjectsCollection.doc(project.id).update(project.toJson());
  }

  void deleteProject(Project project) {
    try {
      firestoreProjectsCollection.doc(project.id).delete();
      for (final dynamic openRoleId in project.openRoles ?? <dynamic>[]) {
        final String id = openRoleId as String;
        _firebaseProjectOpenRoleRepository.deleteOpenRole(ProjectOpenRole(id: id));
      }

      for (final dynamic articleId in project.articlesId ?? <dynamic>[]) {
        articleRepository.deleteArticle(articleId as String);
      }
    } catch (e) {
      print('deleteProject $e');
    }
  }

  Future<Map<String, String>?> getProjectUserDetails(String ownerId) async {
    try {
      final Map<String, dynamic>? data = (await firestoreUserInstance.doc(ownerId).get()).data();

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
      final DocumentSnapshot<Map<String, dynamic>> json = await firestoreProjectsCollection.doc(id).get();
      final Project project = Project.fromJson(json.data()!);
      return project;
    } catch (e) {
      print('getProjectById: ${e.toString()}');
    }
    return Project.empty;
  }

  Future<List<Project>> getOwnedProjectsByUid(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> query = await firestoreProjectsCollection.where('owner_id', isEqualTo: uid).get();
    return _userProjectFromQuery(query);
  }

  Future<List<Project>> getJoinedProjectsByUid(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> query =
        await firestoreProjectsCollection.where('members_uid', arrayContains: uid).where('owner_id', isNotEqualTo: uid).get();
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
          (await firestoreProjectsCollection.orderBy('timestamp', descending: true).limit(limit).get())
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
          (await firestoreProjectsCollection.where('organization_id', isEqualTo: organizationId).get())
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
    final List<Project> projects = (await firestoreProjectsCollection.get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> projectJson) => Project.fromJson(projectJson.data()))
        .toList();
    return projects;
  }

  Future<List<Project>> getProjectsByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return <Project>[];
    }
    final QuerySnapshot<Map<String, dynamic>> projectsQuery = await firestoreProjectsCollection.where('id', whereIn: ids).get();
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
