import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/likes/project_like.dart';

class FirebaseProjectLikesRepository{
  final CollectionReference<Map<String, dynamic>> firestoreProjectsLikesCollection =
      FirebaseFirestore.instance.collection('projects_likes');

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
}
