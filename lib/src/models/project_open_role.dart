class ProjectOpenRole {
  const ProjectOpenRole({
    this.projectId = '',
    this.title = '',
    this.location = '',
    this.specifications = '',
    this.isRemotePossible = false,
    this.isPaid = false,
    this.timestamp = 0,
  });

  ProjectOpenRole.fromJson(Map<String, dynamic> json)
      : projectId = json['project_id'] as String,
        isPaid = json['is_paid'] as bool,
        location = json['location'] as String,
        title = json['title'] as String,
        timestamp = json['timestamp'] as int,
        isRemotePossible = json['is_remote_possible'] as bool,
        specifications = json['specifications'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'project_id': projectId,
        'is_paid': isPaid,
        'location': location,
        'title': title,
        'specifications': specifications,
        'is_remote_possible': isRemotePossible,
        'timestamp': timestamp
      };

  final String projectId;
  final bool isPaid;
  final String title;
  final String location;
  final bool isRemotePossible;
  final String specifications;
  final int timestamp;
}
