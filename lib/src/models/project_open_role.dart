class ProjectOpenRole {
  const ProjectOpenRole({
    this.projectId = '',
    this.id = '',
    this.title = '',
    this.location = '',
    this.specifications = '',
    this.isRemotePossible = false,
    this.isPaid = false,
    this.timestamp = 0,
    this.applicantsUids = const <String>[],
  });

  ProjectOpenRole.fromJson(Map<String, dynamic> json)
      : projectId = json['project_id'] as String,
        isPaid = json['is_paid'] as bool,
        id = json['id'] as String,
        location = json['location'] as String,
        title = json['title'] as String,
        timestamp = json['timestamp'] as int,
        isRemotePossible = json['is_remote_possible'] as bool,
        specifications = json['specifications'] as String,
        applicantsUids = json['applicants_uids'] as List<dynamic>;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'project_id': projectId,
        'id': id,
        'is_paid': isPaid,
        'location': location,
        'title': title,
        'specifications': specifications,
        'is_remote_possible': isRemotePossible,
        'timestamp': timestamp,
        'applicants_uids': applicantsUids,
      };

  ProjectOpenRole copyWith({
    String? projectId,
    String? id,
    bool? isPaid,
    String? title,
    String? location,
    bool? isRemotePossible,
    String? specifications,
    int? timestamp,
    List<dynamic>? applicantsUids,
  }) {
    return ProjectOpenRole(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      isPaid: isPaid ?? this.isPaid,
      title: title ?? this.title,
      location: location ?? this.location,
      isRemotePossible: isRemotePossible ?? this.isRemotePossible,
      specifications: specifications ?? this.specifications,
      timestamp: timestamp ?? this.timestamp,
      applicantsUids: applicantsUids ?? this.applicantsUids,
    );
  }

  final String projectId;
  final String id;
  final bool isPaid;
  final String title;
  final String location;
  final bool isRemotePossible;
  final String specifications;
  final int timestamp;
  final List<dynamic> applicantsUids;
}
