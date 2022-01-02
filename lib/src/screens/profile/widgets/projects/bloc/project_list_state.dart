part of 'project_list_bloc.dart';

class ProjectListState extends Equatable {
  const ProjectListState({
    this.loaded = false,
    this.projectList = const <Project>[],
    this.user = FullUser.empty,
  });

  final bool loaded;
  final List<Project> projectList;
  final FullUser user;

  ProjectListState copyWith({
    bool? loaded,
    List<Project>? projectList,
    FullUser? user,
  }) {
    return ProjectListState(
      loaded: loaded ?? this.loaded,
      projectList: projectList ?? this.projectList,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => <Object?>[loaded, projectList, user];
}
