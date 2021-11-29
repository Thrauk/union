import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project({this.ownerId,
      this.title, this.shortDescription, this.details, this.tags, this.id});

  final String? title;
  final String? id;
  final String? ownerId;
  final String? shortDescription;
  final String? details;
  final List<String>? tags;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner_id': ownerId,
        'title': title,
        'details': details,
        'short_description': shortDescription,
        'tags': tags
      };

  Project copyWith({
    String? id,
    String? ownerId,
    String? title,
    String? shortDescription,
    String? details,
    List<String>? tags
  }) {
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
  List<Object?> get props => <Object?>[title, shortDescription, details, tags, ownerId, id];
}
