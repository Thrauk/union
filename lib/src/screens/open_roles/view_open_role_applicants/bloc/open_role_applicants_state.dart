part of 'open_role_applicants_bloc.dart';

enum StatusEnum { successful, failed, loading }

class OpenRoleApplicantsState extends Equatable {
  const OpenRoleApplicantsState(
      {this.applicationsItems = const <ProjectOpenRoleApplicationItem>[], this.status = StatusEnum.loading});

  final List<ProjectOpenRoleApplicationItem> applicationsItems;
  final StatusEnum status;

  OpenRoleApplicantsState copyWith({List<ProjectOpenRoleApplicationItem>? applicationsItems, StatusEnum? status}) {
    return OpenRoleApplicantsState(
        applicationsItems: applicationsItems ?? this.applicationsItems, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [applicationsItems, status];
}
