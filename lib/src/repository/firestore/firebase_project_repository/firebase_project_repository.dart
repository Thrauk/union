import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/likes/project_like.dart';
import 'package:union_app/src/models/models.dart';

import '../firestore.dart';

class FirebaseProjectRepository {
  final DocumentReference<Map<String, dynamic>> firestoreProjectsDocument =
      FirebaseFirestore.instance.collection('projects').doc();

  final CollectionReference<Map<String, dynamic>> firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final CollectionReference<Map<String, dynamic>> firestoreProjectsLikesCollection =
      FirebaseFirestore.instance.collection('projects_likes');

  final FirebaseProjectOpenRoleRepository _firebaseProjectOpenRoleRepository = FirebaseProjectOpenRoleRepository();

  final CollectionReference<Map<String, dynamic>> firestoreUserInstance = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository userRepository = FirebaseUserRepository();
  FirebaseArticleRepository articleRepository = FirebaseArticleRepository();

  void createProject(Project project) {
    final Project projectToSave = project.copyWith(id: firestoreProjectsDocument.id);
    firestoreUserInstance.doc(project.ownerId).update({
      'projects_ids': FieldValue.arrayUnion([projectToSave.id])
    });
    firestoreProjectsDocument.set(projectToSave.toJson());
  }

  void updateProject(Project project) {
    firestoreProjectsCollection.doc(project.id).update(project.toJson());
  }

  void deleteProject(Project project) {
    try {
      firestoreProjectsCollection.doc(project.id).delete();
      firestoreUserInstance.doc(project.ownerId).update({
        'projects_ids': FieldValue.arrayRemove([project.id])
      });

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
    final QuerySnapshot<Map<String, dynamic>> query = await firestoreProjectsCollection.where('members_uid', arrayContains: uid).where('owner_id', isNotEqualTo: uid).get();
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

  void deleteMemberFromProject(String userId, String projectId) {
    firestoreProjectsCollection.doc(projectId).update({
      'members_uid': FieldValue.arrayRemove(<String>[userId])
    });
  }

  Future<List<FullUser>> getMembers(String projectId) async {
    final List<FullUser> users = List<FullUser>.empty(growable: true);
    final Map<String, dynamic>? projectData;
    final List<String> usersIds;
    try {
      projectData = (await firestoreProjectsCollection.doc(projectId).get()).data();

      usersIds = (projectData!['members_uid'] as List<dynamic>).map((el) => el as String).toList();

      for (final String id in usersIds) {
        final FullUser user = await userRepository.getFullUserByUid(id);
        if (user != null) {
          users.add(user);
        }
      }
    } catch (e) {
      print('getMembers $e');
    }
    return users;
  }

  Future<bool> verifyIfUserLiked(String projectId, String uid) async {
    try {
      final int like =
          (await firestoreProjectsLikesCollection.where('project_id', isEqualTo: projectId).where('uid', isEqualTo: uid).get())
              .size;
      return like != 0;
    } catch (e) {
      print('verifyIfUserLiked $e');
    }
    return false;
  }

  Future<void> removeLikeFromProject(String projectId, String uid) async {
    try {
      await firestoreProjectsLikesCollection.where('project_id', isEqualTo: projectId).where('uid', isEqualTo: uid).get().then(
            (QuerySnapshot<Map<String, dynamic>> value) => value.docs.forEach(
              (QueryDocumentSnapshot<Map<String, dynamic>> element) {
                firestoreProjectsLikesCollection.doc(element.id).delete();
              },
            ),
          );
    } catch (e) {
      print('removeLikeFromProject $e');
    }
  }

  Future<int> getLikesNumber(String projectId) async {
    try {
      final int likes = (await firestoreProjectsLikesCollection.where('project_id', isEqualTo: projectId).get()).size;
      return likes;
    } catch (e) {
      print('getLikesNumber $e');
      return 0;
    }
  }

  Future<void> addLikeToProject(String projectId, String uid) async {
    try {
      final String id = firestoreProjectsLikesCollection.doc().id;
      final int timestamp = DateTime.now().microsecondsSinceEpoch;
      final ProjectLike projectLike = ProjectLike(uid, id, projectId, timestamp);
      firestoreProjectsLikesCollection.doc(id).set(projectLike.toJson());
    } catch (e) {
      print('addLikeToProject $e');
    }
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
