part of 'open_role_details_bloc.dart';

class OpenRoleDetailsState extends Equatable {
  const OpenRoleDetailsState(
      {this.project = const Project(), this.status = FormzStatus.pure});

  final Project project;
  final FormzStatus status;

  @override
  List<Object?> get props => [project];

  OpenRoleDetailsState copyWith({Project? project, FormzStatus? status}) {
    return OpenRoleDetailsState(
        project: project ?? this.project, status: status ?? this.status);
  }
}
