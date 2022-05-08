part of 'invite_users_to_project_bloc.dart';

abstract class InviteUsersToProjectEvent {
  const InviteUsersToProjectEvent();
}

class SearchIconPressed extends InviteUsersToProjectEvent {}

class InvitePressed extends InviteUsersToProjectEvent {
  InvitePressed({required this.receiverUid, required this.senderUid, required this.projectId});

  String receiverUid;
  String senderUid;
  String projectId;
}

class DismissPressed extends InviteUsersToProjectEvent {
  DismissPressed({required this.projectId, required this.receiverUid});

  String receiverUid;
  String projectId;
}

class TextChanged extends InviteUsersToProjectEvent {
  TextChanged(this.value);

  String value;
}

class GetProjectInvites extends InviteUsersToProjectEvent {
  GetProjectInvites(this.projectId);

  String projectId;
}
