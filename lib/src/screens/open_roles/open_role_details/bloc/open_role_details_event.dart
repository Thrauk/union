part of 'open_role_details_bloc.dart';

abstract class OpenRoleDetailsEvent {
  const OpenRoleDetailsEvent();
}

class GetProjectDetails extends OpenRoleDetailsEvent{
  GetProjectDetails(this.projectId);

  final String projectId;
}
