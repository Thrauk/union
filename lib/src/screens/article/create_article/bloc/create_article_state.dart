part of 'create_article_bloc.dart';

class CreateArticleState extends Equatable {
  const CreateArticleState({
    this.body = const ArticleBody.pure(),
    this.tag = const TagName.pure(),
    this.tagItems = const <TagName>[],
    this.status = FormzStatus.pure,
  });

  final ArticleBody body;
  final List<TagName> tagItems;
  final FormzStatus status;
  final TagName tag;

  CreateArticleState copyWith(
      {ArticleBody? body,
      FormzStatus? status,
      List<TagName>? tagItems,
      TagName? tag}) {
    return CreateArticleState(
      body: body ?? this.body,
      status: status ?? this.status,
      tag: tag ?? this.tag,
      tagItems: tagItems ?? this.tagItems,
    );
  }

  @override
  List<Object?> get props => <Object>[body, tag, tagItems, status];
}
