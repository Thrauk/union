part of 'popular_projects_bloc.dart';

enum WidgetStatus { INITIAL, LOADING, LOADED, FAILED }

class PopularProjectsState extends Equatable {
  const PopularProjectsState({this.projects = const <Project>[], this.status = WidgetStatus.INITIAL});

  final List<Project> projects;

  final WidgetStatus status;

  @override
  List<Object?> get props => <Object>[projects, status];
}

