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
      this.projectsIds,
      this.followers,
      this.following,
      this.isOpenForCollaborations = false});

  FullUser.fromJson(Map<String, dynamic> json)
      : photo = json['photo'] as String?,
        id = json['id'] as String,
        displayName = json['displayName'] as String,
        email = json['email'] as String,
        description = json['description'] as String?,
        location = json['location'] as String?,
        jobTitle = json['jobTitle'] as String?,
        projectsIds = json['projects_ids'] as List<dynamic>?,
        followers = json['followers'] as List<dynamic>?,
        following = json['following'] as List<dynamic>?,
        isOpenForCollaborations = json['is_open_for_collaborations'] as bool;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photo': photo,
        'description': description,
        'location': location,
        'jobTitle': jobTitle,
        'projects_ids': projectsIds,
        'following': following,
        'followers': followers,
        'is_open_for_collaborations': isOpenForCollaborations
      }..removeWhere((String key, dynamic value) => value == null);

  final String? email;

  final String id;

  final String? displayName;

  final String? photo;

  final String? description;

  final String? location;

  final String? jobTitle;

  final List<dynamic>? projectsIds;

  final List<dynamic>? followers;
  final List<dynamic>? following;

  final bool isOpenForCollaborations;

  static const FullUser empty = FullUser(id: '');

  bool get isEmpty => this == FullUser.empty;

  bool get isNotEmpty => this != FullUser.empty;

  FullUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photo,
    String? description,
    String? location,
    String? jobTitle,
    List<dynamic>? projectsIds,
    List<dynamic>? followers,
    List<dynamic>? following,
    bool? isOpenForCollaborations,
  }) {
    return FullUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photo: photo ?? this.photo,
      description: description ?? this.description,
      location: location ?? this.location,
      jobTitle: jobTitle ?? this.jobTitle,
      projectsIds: projectsIds ?? this.projectsIds,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isOpenForCollaborations: isOpenForCollaborations ?? this.isOpenForCollaborations,
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
        projectsIds,
        following,
        followers,
        isOpenForCollaborations
      ];
}
