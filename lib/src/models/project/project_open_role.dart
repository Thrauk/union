class ProjectOpenRole {
  const ProjectOpenRole({
    this.projectId = '',
    this.id = '',
    this.ownerId = '',
    this.title = '',
    this.location = '',
    this.specifications = '',
    this.experienceLevel = '',
    this.isRemotePossible = false,
    this.isPaid = false,
    this.timestamp = 0,
  });

  ProjectOpenRole.fromJson(Map<String, dynamic> json)
      : projectId = json['project_id'] as String,
        isPaid = json['is_paid'] as bool,
        id = json['id'] as String,
        ownerId = json['owner_id'] as String,
        location = json['location'] as String,
        experienceLevel = json['experience_level'] as String,
        title = json['title'] as String,
        timestamp = json['timestamp'] as int,
        isRemotePossible = json['is_remote_possible'] as bool,
        specifications = json['specifications'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'project_id': projectId,
        'id': id,
        'owner_id': ownerId,
        'is_paid': isPaid,
        'experience_level': experienceLevel,
        'location': location,
        'title': title,
        'specifications': specifications,
        'is_remote_possible': isRemotePossible,
        'timestamp': timestamp,
      };

  ProjectOpenRole copyWith({
    String? projectId,
    String? id,
    String? ownerId,
    String? experienceLevel,
    bool? isPaid,
    String? title,
    String? location,
    bool? isRemotePossible,
    String? specifications,
    int? timestamp,
  }) {
    return ProjectOpenRole(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      projectId: projectId ?? this.projectId,
      isPaid: isPaid ?? this.isPaid,
      title: title ?? this.title,
      location: location ?? this.location,
      isRemotePossible: isRemotePossible ?? this.isRemotePossible,
      specifications: specifications ?? this.specifications,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  static const ProjectOpenRole empty = ProjectOpenRole();

  final String projectId;
  final String id;
  final String ownerId;
  final String experienceLevel;
  final bool isPaid;
  final String title;
  final String location;
  final bool isRemotePossible;
  final String specifications;
  final int timestamp;
}
