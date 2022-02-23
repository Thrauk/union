import 'dart:io';

import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  const Organization({
    this.id = '',
    required this.name,
    required this.ownerId,
    required this.description,
    required this.type,
    required this.category,
    required this.location,
    this.members = const <String>[],
    this.photoUrl = '',
    this.photo,
  });

  Organization.fromJson(Map<String, dynamic> json, {this.photo})
      : name = json['name'] as String,
        id = json['id'] as String,
        ownerId = json['owner_id'] as String,
        description = json['description'] as String,
        type = json['type'] as String,
        location = json['location'] as String,
        category = json['category'] as String,
        members = (json['members'] as List<dynamic>).cast<String>(),
        photoUrl = json['photo_url'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name' : name,
        'id' : id,
        'owner_id': ownerId,
        'description': description,
        'type': type,
        'location': location,
        'category': category,
        'members': members,
        'photo_url': photoUrl,
      }..removeWhere((String key, dynamic value) => value == null);

  static const Organization empty = Organization(
    id: '',
    name: '',
    type: '',
    ownerId: '',
    location: '',
    category: '',
    description: '',
  );

  Organization copyWith({
    String? name,
    String? id,
    String? ownerId,
    String? description,
    String? type,
    String? category,
    String? location,
    List<String>? members,
    String? photoUrl,
  }) {
    return Organization(
      name: name ?? this.name,
      id: id ?? this.id,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      type: type ?? this.type,
      category: category ?? this.category,
      location: location ?? this.location,
      members: members ?? this.members,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  final String name;
  final String id;
  final String ownerId;
  final List<String> members;
  final String description;
  final String type;
  final String location;
  final String category;
  final String photoUrl;
  final File? photo;

  @override
  List<Object?> get props => <Object?>[
        name,
        ownerId,
        members,
        description,
        type,
        location,
        category,
        photoUrl,
        photo,
      ];
}
