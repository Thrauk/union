import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project(
      {this.ownerId = '',
      this.title = '',
      this.shortDescription = '',
      this.details = '',
      this.timestamp = 0,
      this.tags = const <String>[],
      this.openRoles = const <dynamic>[],
      this.membersUid = const <String>[],
      this.id = '',
      this.organizationId = ''});

  Project.fromJson(Map<String, dynamic> json)
      : ownerId = json['owner_id'] as String,
        id = json['id'] as String,
        details = json['details'] as String,
        shortDescription = json['short_description'] as String,
        tags = json['tags'] as List<dynamic>,
        openRoles = json['open_roles'] as List<dynamic>,
        membersUid = json['members_uid'] as List<dynamic>,
        timestamp = json['timestamp'] as int,
        title = json['title'] as String,
        organizationId = (json['organization_id'] ?? '') as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner_id': ownerId,
        'title': title,
        'details': details,
        'short_description': shortDescription,
        'tags': tags,
        'open_roles': openRoles,
        'timestamp': timestamp,
        'organization_id': organizationId,
        'members_uid': membersUid,
      };

  final String? title;
  final String? id;
  final String ownerId;
  final String shortDescription;
  final String details;
  final int timestamp;
  final String organizationId;
  final List<dynamic>? tags;
  final List<dynamic>? openRoles;
  final List<dynamic>? membersUid;

  static const Project empty = Project();

  bool get isEmpty => this == Project.empty;

  Project copyWith({
    String? id,
    String? ownerId,
    String? title,
    String? shortDescription,
    String? details,
    int? timestamp,
    List<dynamic>? openRoles,
    List<dynamic>? tags,
    List<String>? membersUid,
    String? organizationId,
  }) {
    return Project(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      details: details ?? this.details,
      timestamp: timestamp ?? this.timestamp,
      openRoles: openRoles ?? this.openRoles,
      tags: tags ?? this.tags,
      organizationId: organizationId ?? this.organizationId,
      membersUid: membersUid ?? this.membersUid,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[title, shortDescription, details, tags, ownerId, id, openRoles, organizationId, membersUid];
}
