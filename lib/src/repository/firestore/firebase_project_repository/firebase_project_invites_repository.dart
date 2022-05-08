import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/project/project_invite.dart';

class FirebaseProjectInvitesRepository {
  final CollectionReference<Map<String, dynamic>> _firestoreProjectInvitesCollection =
      FirebaseFirestore.instance.collection('projects_invites');

  Future<List<ProjectInvite>> getProjectsInvites(String projectId) async {
    final QuerySnapshot<Map<String, dynamic>> invitesQuery =
        await _firestoreProjectInvitesCollection.where('project_id', isEqualTo: projectId).get();
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

  void createInvite(String senderUid, String receiverUid, String projectId) {
    final String id = _firestoreProjectInvitesCollection.doc().id;
    final ProjectInvite projectInvite =
        ProjectInvite(senderUid: senderUid, receiverUid: receiverUid, projectId: projectId, id: id);
    _firestoreProjectInvitesCollection.doc(id).set(projectInvite.toJson());
  }

  void deleteInvite(String projectId, String receiverUid) {
      _firestoreProjectInvitesCollection
          .where('project_id', isEqualTo: projectId)
          .where('receiver_uid', isEqualTo: receiverUid)
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> value) =>
          _firestoreProjectInvitesCollection.doc(value.docs.first.id).delete());
  }
}
