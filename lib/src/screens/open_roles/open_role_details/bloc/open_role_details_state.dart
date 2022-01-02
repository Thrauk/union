part of 'open_role_details_bloc.dart';

class OpenRoleDetailsState extends Equatable {
  const OpenRoleDetailsState(
      {this.project = const Project(),
      this.status = FormzStatus.pure,
      this.alreadyAppliedToProject = false,
      this.notice = ''});

  final Project project;
  final FormzStatus status;
  final bool alreadyAppliedToProject;
  final String notice;

  @override
  List<Object?> get props => [project, alreadyAppliedToProject, notice];

  OpenRoleDetailsState copyWith({
    Project? project,
    FormzStatus? status,
    bool? alreadyAppliedToProject,
    String? notice,
  }) {
    return OpenRoleDetailsState(
      project: project ?? this.project,
      status: status ?? this.status,
      notice: notice ?? this.notice,
      alreadyAppliedToProject:
          alreadyAppliedToProject ?? this.alreadyAppliedToProject,
    );
  }
}
