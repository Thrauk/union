part of 'project_posts_bloc.dart';

@immutable
abstract class ProjectPostsEvent {}

class GetArticles extends ProjectPostsEvent {
  GetArticles(this.articlesId);

  final List<String> articlesId;
}
