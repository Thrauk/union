
part of 'user_articles_page_bloc.dart';


enum PageStatus { initial, loading, success, failed }

class UserArticlesPageState extends Equatable {
  const UserArticlesPageState(
      {this.articles = const <Article>[], this.status = PageStatus.initial});

  final List<Article> articles;
  final PageStatus status;

  UserArticlesPageState copyWith({
    List<Article>? articles,
    PageStatus? status,
  }) {
    return UserArticlesPageState(
      articles: articles ?? this.articles,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [articles, status];
}

