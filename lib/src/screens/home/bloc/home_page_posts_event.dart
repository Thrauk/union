part of 'home_page_posts_bloc.dart';

abstract class HomePagePostsEvent {
  const HomePagePostsEvent();
}

class GetArticles extends HomePagePostsEvent {}

class GetProjects extends HomePagePostsEvent {}

class GetAll extends HomePagePostsEvent {}
