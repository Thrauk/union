part of 'open_role_details_bloc.dart';

abstract class OpenRoleDetailsEvent {
  const OpenRoleDetailsEvent();
}

class GetProjectDetails extends OpenRoleDetailsEvent {
  GetProjectDetails(this.projectId);

  final String projectId;
}

class NoticeChanged extends OpenRoleDetailsEvent {
  const NoticeChanged(this.value);

  final String value;
}

class ApplyButtonPressed extends OpenRoleDetailsEvent {
  ApplyButtonPressed(this.uid, this.openRoleId);

  final String uid;
  final String openRoleId;
}

class VerifyIfUserAlreadyApplied extends OpenRoleDetailsEvent {
  VerifyIfUserAlreadyApplied(this.uid, this.openRoleId);

  final String uid;
  final String openRoleId;
}
