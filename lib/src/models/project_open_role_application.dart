class ProjectOpenRoleApplication {
  const ProjectOpenRoleApplication(
      {this.uid = '', this.notice = '', this.openRoleId = ''});

  ProjectOpenRoleApplication.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        openRoleId = json['open_role_id'] as String,
        notice = json['notice'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'open_role_id': openRoleId,
        'notice': notice,
      };

  ProjectOpenRoleApplication copyWith({
    String? uid,
    String? notice,
    String? openRoleId,
  }) {
    return ProjectOpenRoleApplication(
      uid: uid ?? this.uid,
      notice: notice ?? this.notice,
      openRoleId: openRoleId ?? this.openRoleId,
    );
  }

  final String uid;
  final String notice;
  final String openRoleId;
}
