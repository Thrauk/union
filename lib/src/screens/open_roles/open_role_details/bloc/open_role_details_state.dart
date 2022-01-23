part of 'open_role_details_bloc.dart';

class OpenRoleDetailsState extends Equatable {
  const OpenRoleDetailsState({
    this.project = const Project(),
    this.status = FormzStatus.pure,
    this.id = '',
    this.alreadyAppliedToProject = false,
  });

  final Project project;
  final FormzStatus status;
  final bool alreadyAppliedToProject;
  final String id;

  @override
  List<Object?> get props => [project, alreadyAppliedToProject, id];

  OpenRoleDetailsState copyWith({
    Project? project,
    FormzStatus? status,
    bool? alreadyAppliedToProject,
    String? id,
  }) {
    return OpenRoleDetailsState(
      project: project ?? this.project,
      status: status ?? this.status,
      id: id ?? this.id,
      alreadyAppliedToProject: alreadyAppliedToProject ?? this.alreadyAppliedToProject,
    );
  }
}
