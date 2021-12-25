part of 'edit_article_bloc.dart';

@immutable
class EditArticleState extends Equatable {
  const EditArticleState({
    this.article = const Article(),
    this.tag =  const TagName.pure(),
    this.status = FormzStatus.pure,
  });

  final Article article;
  final FormzStatus status;
  final TagName tag;

  EditArticleState copyWith({
    Article? article,
    FormzStatus? status,
    TagName? tag}) {
    return EditArticleState(
      article: article ?? this.article,
      status: status ?? this.status,
      tag: tag ?? this.tag,
    );
  }

  @override
  List<Object?> get props => [article, tag, status];
}