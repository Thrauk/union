part of 'user_projects_bloc.dart';

@immutable
abstract class UserProjectsEvent {}

class GetProjects extends UserProjectsEvent {
  GetProjects(this.uid, this.projectType);

  final String uid;
  final ProjectType projectType;
}

class ProjectTypeChanged extends UserProjectsEvent {
  ProjectTypeChanged(this.projectType, this.uid);

  final ProjectType projectType;
  final String uid;
}
