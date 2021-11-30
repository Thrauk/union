import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project(
      {required this.ownerId,
      this.title,
      required this.shortDescription,
      required this.details,
      this.tags,
      this.id});

  Project.fromJson(Map<String, dynamic> json)
      : ownerId = json['owner_id'] as String,
        id = json['id'] as String,
        details = json['details'] as String,
        shortDescription = json['short_description'] as String,
        tags = json['tags'] as List<dynamic>,
        title = json['title'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner_id': ownerId,
        'title': title,
        'details': details,
        'short_description': shortDescription,
        'tags': tags
      };

  final String? title;
  final String? id;
  final String ownerId;
  final String shortDescription;
  final String details;
  final List<dynamic>? tags;

  Project copyWith(
      {String? id,
      String? ownerId,
      String? title,
      String? shortDescription,
      String? details,
      List<dynamic>? tags}) {
    return Project(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      details: details ?? this.details,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        title,
        shortDescription,
        details,
        tags,
        ownerId,
        id,
      ];
}
