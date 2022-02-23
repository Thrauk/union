class ProjectOpenRoleApplication {
  const ProjectOpenRoleApplication({this.uid = '', this.notice = '', this.openRoleId = '', this.cvUrl = '', this.id = ''});

  ProjectOpenRoleApplication.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        openRoleId = json['open_role_id'] as String,
        notice = json['notice'] as String,
        cvUrl = json['cv_url'] as String,
        id = json['id'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'open_role_id': openRoleId,
        'notice': notice,
        'id': id,
        'cv_url': cvUrl,
      };

  ProjectOpenRoleApplication copyWith({
    String? uid,
    String? notice,
    String? openRoleId,
    String? id,
    String? cvUrl,
  }) {
    return ProjectOpenRoleApplication(
      uid: uid ?? this.uid,
      notice: notice ?? this.notice,
      openRoleId: openRoleId ?? this.openRoleId,
      cvUrl: cvUrl ?? this.cvUrl,
      id: id ?? this.id,
    );
  }

  final String uid;
  final String notice;
  final String openRoleId;
  final String id;
  final String cvUrl;
}
