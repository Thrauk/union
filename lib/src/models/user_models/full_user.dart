import 'package:equatable/equatable.dart';

class FullUser extends Equatable {
  const FullUser(
      {required this.id,
      this.email,
      this.displayName,
      this.photo,
      this.description,
      this.location,
      this.jobTitle});

  FullUser.fromJson(Map<String, dynamic> json)
      : photo = json['photo'] as String?,
        id = json['id'] as String,
        displayName = json['displayName'] as String,
        email = json['email'] as String,
        description = json['description'] as String?,
        location = json['location'] as String?,
        jobTitle = json['jobTitle'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> retJson = {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photo': photo,
      'description': description,
      'location': location,
      'jobTitle': jobTitle,
    };
    return retJson;
  }

  FullUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photo,
    String? description,
    String? location,
    String? jobTitle,
  }) {
    return FullUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photo: photo ?? this.photo,
      description: description ?? this.description,
      location: location ?? this.location,
      jobTitle: jobTitle ?? this.jobTitle,
    );
  }

  final String? email;

  final String id;

  final String? displayName;

  final String? photo;

  final String? description;

  final String? location;

  final String? jobTitle;

  static const FullUser empty = FullUser(id: '');

  bool get isEmpty => this == FullUser.empty;

  bool get isNotEmpty => this != FullUser.empty;

  @override
  List<Object?> get props =>
      <Object?>[email, id, displayName, photo, description, location, jobTitle];
}
