part of 'open_role_details_bloc.dart';

class OpenRoleDetailsState extends Equatable {
  const OpenRoleDetailsState(
      {this.project = const Project(),
      this.status = FormzStatus.pure,
      this.alreadyAppliedToProject = false});

  final Project project;
  final FormzStatus status;
  final bool alreadyAppliedToProject;

  @override
  List<Object?> get props => [project, alreadyAppliedToProject];

  OpenRoleDetailsState copyWith({
    Project? project,
    FormzStatus? status,
    bool? alreadyAppliedToProject,
  }) {
    return OpenRoleDetailsState(
      project: project ?? this.project,
      status: status ?? this.status,
      alreadyAppliedToProject:
          alreadyAppliedToProject ?? this.alreadyAppliedToProject,
    );
  }
}
