part of 'user_projects_invites_bloc.dart';

@immutable
abstract class UserProjectsInvitesEvent {}

class GetUserInvites extends UserProjectsInvitesEvent {
  GetUserInvites(this.uid);

  final String uid;
}

class AcceptPressed extends UserProjectsInvitesEvent {
  AcceptPressed(this.inviteId, this.projectId, this.uid);

  final String inviteId;
  final String projectId;
  final String uid;

}

class DeletePressed extends UserProjectsInvitesEvent {
  DeletePressed(this.inviteId);

  final String inviteId;
}
