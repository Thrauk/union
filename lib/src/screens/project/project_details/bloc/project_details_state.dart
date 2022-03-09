part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  const ProjectDetailsState({this.openRoles = const <ProjectOpenRole>[], this.membersList = const <FullUser>[]});

  final List<ProjectOpenRole> openRoles;
  final List<FullUser> membersList;

  ProjectDetailsState copyWith({List<ProjectOpenRole>? openRoles, List<FullUser>? membersList}) {
    return ProjectDetailsState(openRoles: openRoles ?? this.openRoles, membersList: membersList ?? this.membersList);
  }

  @override
  List<Object?> get props => [openRoles, membersList];
}
