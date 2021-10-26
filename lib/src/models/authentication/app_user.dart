import 'package:equatable/equatable.dart';

class AppUser extends Equatable {

  const AppUser({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  AppUser.fromJson(Map<String, dynamic> json)
      : photo = json['photo'] as String?,
        id = json['id'] as String,
        name = json['name'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'email': email,
    'name': name,
    'photo' : photo,
  };

  final String? email;

  final String id;

  final String? name;

  final String? photo;

  static const AppUser empty = AppUser(id: '');

  bool get isEmpty => this == AppUser.empty;

  bool get isNotEmpty => this != AppUser.empty;

  @override
  List<Object?> get props => <Object?>[email, id, name, photo];
}
