part of 'open_role_applicants_bloc.dart';

class OpenRoleApplicantsState extends Equatable {
  const OpenRoleApplicantsState({this.applicationsItems = const <ProjectOpenRoleApplicationItem>[]});

  final List<ProjectOpenRoleApplicationItem> applicationsItems;

  OpenRoleApplicantsState copyWith({List<ProjectOpenRoleApplicationItem>? applicationsItems}) {
    return OpenRoleApplicantsState(applicationsItems: applicationsItems ?? this.applicationsItems);
  }

  @override
  List<Object?> get props => [applicationsItems];
}
