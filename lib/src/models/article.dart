import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article(
      {this.ownerId = '',
      this.body = '',
      this.tags = const <String>[],
      this.likesUsersIds = const <String>[],
      this.date = 0,
      this.id = ''});

  Article.fromJson(Map<String, dynamic> json)
      : ownerId = json['owner_id'] as String,
        id = json['id'] as String,
        body = json['body'] as String,
        date = json['date'] as int,
        tags = json['tags'] as List<dynamic>,
        likesUsersIds = json['likes_user_ids'] as List<dynamic>;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner_id': ownerId,
        'body': body,
        'date': date,
        'tags': tags,
        'likes_user_ids' : likesUsersIds,
      };

  final String? id;
  final String? body;
  final String ownerId;
  final List<dynamic>? tags;
  final List<dynamic>? likesUsersIds;
  final int date;

  static const Article empty = Article();

  bool get isEmpty => this == Article.empty;

  Article copyWith(
      {String? id,
      String? ownerId,
      String? body,
      List<dynamic>? tags,
      List<dynamic>? likesUsersIds,
      int? date}) {
    return Article(
      id: id ?? this.id,
      date: date ?? this.date,
      ownerId: ownerId ?? this.ownerId,
      body: body ?? this.body,
      tags: tags ?? this.tags,
      likesUsersIds: likesUsersIds ?? this.likesUsersIds,
    );
  }

  @override
  List<Object?> get props => <Object?>[body, tags, ownerId, id, date, likesUsersIds];
}
