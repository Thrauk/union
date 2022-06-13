class ProjectLike {
  ProjectLike(this.uid, this.id, this.projectId, this.timestamp);

  ProjectLike.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        uid = json['uid'] as String,
        projectId = json['project_id'] as String,
        timestamp = json['timestamp'] as int;

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'uid': uid, 'project_id': projectId, 'timestamp': timestamp};

  final String uid;
  final String id;
  final String projectId;
  final int timestamp;
}
