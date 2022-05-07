class ProjectInvite {
  const ProjectInvite({required this.senderUid, required this.receiverUid, required this.projectId, this.id = ''});

  ProjectInvite.fromJson(Map<String, dynamic> json)
      : senderUid = json['sender_uid'] as String,
        receiverUid = json['receiver_uid'] as String,
        projectId = json['project_id'] as String,
        id = json['id'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sender_uid': senderUid,
        'receiver_uid': receiverUid,
        'project_id': projectId,
        'id': id,
      };

  static const ProjectInvite empty = ProjectInvite(senderUid: '', receiverUid: '', projectId: '', id: '');

  final String receiverUid;
  final String senderUid;
  final String projectId;
  final String id;
}
