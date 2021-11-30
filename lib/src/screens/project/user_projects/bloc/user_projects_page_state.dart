part of 'user_projects_page_bloc.dart';

enum PageStatus { initial, loading, success, failed }

class UserProjectsPageState extends Equatable {
  const UserProjectsPageState(
      {this.projects = const <Project>[], this.status = PageStatus.initial});

  final List<Project> projects;
  final PageStatus status;

  UserProjectsPageState copyWith({
    List<Project>? projects,
    PageStatus? status,
  }) {
    return UserProjectsPageState(
      projects: projects ?? this.projects,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [projects, status];
}
