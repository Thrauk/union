part of 'open_role_applicants_bloc.dart';

abstract class OpenRoleApplicantsEvent {
  const OpenRoleApplicantsEvent();
}

class GetApplicantsList extends OpenRoleApplicantsEvent{
  GetApplicantsList(this.openRoleId);

  final String openRoleId;
}
