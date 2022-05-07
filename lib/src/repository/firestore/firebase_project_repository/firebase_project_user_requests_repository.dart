import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/project/project_invite.dart';

class FirebaseProjectUserRequestsRepository {
  final CollectionReference<Map<String, dynamic>> firestoreProjectInvitesCollection =
      FirebaseFirestore.instance.collection('projects_user_requests');

  Future<List<ProjectInvite>> getProjectsInvites(String projectId) async {
    final QuerySnapshot<Map<String, dynamic>> invitesQuery =
        await firestoreProjectInvitesCollection.where('project_id', isEqualTo: projectId).get();
    return _getProjectInvitesFromQuery(invitesQuery);
  }

  List<ProjectInvite> _getProjectInvitesFromQuery(QuerySnapshot<Map<String, dynamic>> invitesQuery) {
    return invitesQuery.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
      final Map<String, dynamic> json = e.data();
      if (json != null) {
        return ProjectInvite.fromJson(json);
      } else
        return ProjectInvite.empty;
    }).toList();
  }
}
