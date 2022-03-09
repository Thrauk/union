part of 'project_members_bloc.dart';

abstract class ProjectMembersEvent {
  const ProjectMembersEvent();
}

class DeleteMemberPressed extends ProjectMembersEvent {
  DeleteMemberPressed(this.userId, this.projectId);

  final String userId;
  final String projectId;
}

class SetMembers extends ProjectMembersEvent {
  SetMembers(this.users);

  final List<FullUser> users;
}
