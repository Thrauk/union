part of 'user_projects_bloc.dart';

enum PageStatus { initial, loading, success, failed }
enum ProjectType { OWNED, JOINED, ALL }

class UserProjectsState extends Equatable {
  const UserProjectsState(
      {this.projects = const <Project>[], this.status = PageStatus.initial, this.projectType = ProjectType.OWNED});

  final List<Project> projects;
  final ProjectType projectType;
  final PageStatus status;

  UserProjectsState copyWith({List<Project>? projects, PageStatus? status, ProjectType? projectType}) {
    return UserProjectsState(
      projects: projects ?? this.projects,
      status: status ?? this.status,
      projectType: projectType ?? this.projectType,
    );
  }

  @override
  List<Object?> get props => <Object?>[projects, status, projectType];
}
