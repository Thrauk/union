part of 'user_projects_page_bloc.dart';

@immutable
abstract class UserProjectsPageEvent {}

class GetProjects extends UserProjectsPageEvent {
  GetProjects(this.uid);

  final String uid;
}
