part of 'view_user_applications_bloc.dart';

@immutable
abstract class ViewUserApplicationsEvent {}

class GetApplications extends ViewUserApplicationsEvent{
  GetApplications(this.uid);

  final String uid;
}
