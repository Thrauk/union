part of 'popular_projects_bloc.dart';

abstract class PopularProjectsEvent {
  const PopularProjectsEvent();
}

class GetPopularProjects extends PopularProjectsEvent {}
