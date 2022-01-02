class ProjectOpenRoleApplication {
  const ProjectOpenRoleApplication({this.uid = '', this.notice = ''});

  ProjectOpenRoleApplication.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        notice = json['notice'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'notice': notice,
      };

  final String uid;
  final String notice;
}
