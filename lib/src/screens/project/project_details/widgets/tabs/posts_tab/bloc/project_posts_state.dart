part of 'project_posts_bloc.dart';

enum PageStatus { INITIAL, LOADING, FAILED, LOADED }

class ProjectPostsState extends Equatable {
  const ProjectPostsState({this.articles = const <Article>[], this.status = PageStatus.INITIAL});

  final List<Article> articles;
  final PageStatus status;

  ProjectPostsState copyWith({List<Article>? articles, PageStatus? status}) {
    return ProjectPostsState(articles: articles ?? this.articles, status: status ?? this.status);
  }

  @override
  List<Object?> get props => <Object>[articles, status];
}
