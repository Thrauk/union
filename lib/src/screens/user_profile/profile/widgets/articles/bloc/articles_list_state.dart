part of 'articles_list_bloc.dart';

class ArticlesListState extends Equatable {
  const ArticlesListState({
    this.loaded = false,
    this.articleList = const <Article>[],
  });

  final bool loaded;
  final List<Article> articleList;

  ArticlesListState copyWith({
    bool? loaded,
    List<Article>? articleList,
  }) {
    return ArticlesListState(
      loaded: loaded ?? this.loaded,
      articleList: articleList ?? this.articleList,
    );
  }

  @override
  List<Object?> get props => <Object?>[loaded, articleList];
}

