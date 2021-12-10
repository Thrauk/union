import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article(
      {this.ownerId = '',
      this.body = '',
      this.tags = const <String>[],
      this.id = ''});

  Article.fromJson(Map<String, dynamic> json)
      : ownerId = json['owner_id'] as String,
        id = json['id'] as String,
        body = json['body'] as String,
        tags = json['tags'] as List<dynamic>;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner_id': ownerId,
        'body': body,
        'tags': tags
      };

  final String? id;
  final String? body;
  final String ownerId;
  final List<dynamic>? tags;

  static const Article empty = Article();

  bool get isEmpty => this == Article.empty;

  Article copyWith(
      {String? id, String? ownerId, String? body, List<dynamic>? tags}) {
    return Article(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      body: body ?? this.body,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        body,
        tags,
        ownerId,
        id,
      ];
}
