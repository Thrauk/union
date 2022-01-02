part of 'view_user_applications_bloc.dart';

enum PageStatus { initial, loading, success, failed }

@immutable
class ViewUserApplicationsState extends Equatable {
  const ViewUserApplicationsState({this.openRoles = const <ProjectOpenRole>[], this.status = PageStatus.initial});

  final List<ProjectOpenRole> openRoles;
  final PageStatus status;

  ViewUserApplicationsState copyWith({
    List<ProjectOpenRole>? openRoles,
    PageStatus? status,
  }) {
    return ViewUserApplicationsState(openRoles: openRoles ?? this.openRoles, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [openRoles, status];
}
