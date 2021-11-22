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

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photo': photo,
      };

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
