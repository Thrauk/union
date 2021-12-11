import 'package:equatable/equatable.dart';

class FullUser extends Equatable {
  const FullUser(
      {required this.id,
      this.email,
      this.displayName,
      this.photo,
      this.description,
      this.location,
      this.jobTitle,
      this.projectsIds});

  FullUser.fromJson(Map<String, dynamic> json)
      : photo = json['photo'] as String?,
        id = json['id'] as String,
        displayName = json['displayName'] as String,
        email = json['email'] as String,
        description = json['description'] as String?,
        location = json['location'] as String?,
        jobTitle = json['jobTitle'] as String?,
        projectsIds = json['projects_ids'] as List<dynamic>?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photo': photo,
        'description': description,
        'location': location,
        'jobTitle': jobTitle,
        'projects_ids': projectsIds,
      };

  final String? email;

  final String id;

  final String? displayName;

  final String? photo;

  final String? description;

  final String? location;

  final String? jobTitle;

  final List<dynamic>? projectsIds;

  static const FullUser empty = FullUser(id: '');

  bool get isEmpty => this == FullUser.empty;

  bool get isNotEmpty => this != FullUser.empty;

  FullUser copyWith(
      {String? id,
      String? email,
      String? displayName,
      String? photo,
      String? description,
      String? location,
      String? jobTitle,
      List<dynamic>? projectsIds}) {
    return FullUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photo: photo ?? this.photo,
      description: description ?? this.description,
      location: location ?? this.location,
      jobTitle: jobTitle ?? this.jobTitle,
      projectsIds: projectsIds ?? this.projectsIds,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        email,
        id,
        displayName,
        photo,
        description,
        location,
        jobTitle,
        projectsIds
      ];
}
