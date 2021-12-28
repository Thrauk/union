part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  const ProjectDetailsState({this.openRoles = const <ProjectOpenRole>[]});

  final List<ProjectOpenRole> openRoles;

  ProjectDetailsState copyWith(List<ProjectOpenRole>? openRoles) {
    return ProjectDetailsState(openRoles: openRoles ?? this.openRoles);
  }

  @override
  List<Object?> get props => [openRoles];
}
