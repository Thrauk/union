import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/project/project_invite_item.dart';
import 'package:union_app/src/repository/firestore/firebase_project_repository/barrel.dart';
import 'package:union_app/src/repository/firestore/firebase_project_repository/firebase_project_invites_repository.dart';
import 'package:union_app/src/repository/firestore/firebase_project_repository/firebase_project_members_repository.dart';
import 'package:union_app/src/repository/firestore/firebase_user/barrel.dart';

part 'user_projects_invites_event.dart';

part 'user_projects_invites_state.dart';

class UserProjectsInvitesBloc extends Bloc<UserProjectsInvitesEvent, UserProjectsInvitesState> {
  UserProjectsInvitesBloc() : super(const UserProjectsInvitesState()) {
    on<GetUserInvites>(_getUserInvites);
    on<AcceptPressed>(_onAcceptPressed);
    on<DeletePressed>(_onDeletePressed);
  }

  final FirebaseProjectInvitesRepository _invitesRepository = FirebaseProjectInvitesRepository();
  final FirebaseProjectRepository _projectRepository = FirebaseProjectRepository();
  final FirebaseUserRepository _userRepository = FirebaseUserRepository();
  final FirebaseProjectMembersRepository _projectMembersRepository = FirebaseProjectMembersRepository();

  Future<FutureOr<void>> _getUserInvites(GetUserInvites event, Emitter<UserProjectsInvitesState> emit) async {
    try {
      final List<ProjectInvite> invites = await _invitesRepository.getUserInvites(event.uid);

      final List<String> usersUids = invites.map((ProjectInvite e) => e.senderUid).toSet().toList();
      final List<String> projectsIds = invites.map((ProjectInvite e) => e.projectId).toSet().toList();

      final List<FullUser> users = await _userRepository.queryUsersByUids(usersUids);
      final List<Project> projects = await _projectRepository.getProjectsByIds(projectsIds);

      final List<ProjectInviteItem> invitesItems = _mapInvites(invites, projects, users).toList();

      emit(state.copyWith(invites: invitesItems, pageStatus: PageStatus.LOADED));
    } catch (e) {
      print(e);
      emit(state.copyWith(pageStatus: PageStatus.FAILED));
    }
  }

  FutureOr<void> _onAcceptPressed(AcceptPressed event, Emitter<UserProjectsInvitesState> emit) {
    final List<ProjectInviteItem> invites = List<ProjectInviteItem>.empty(growable: true);

    try {
      _invitesRepository.deleteInviteById(event.inviteId);
      _projectMembersRepository.addMemberToProject(event.uid, event.projectId);

      invites
        ..addAll(state.invites)
        ..removeWhere((ProjectInviteItem element) => element.id == event.inviteId);

      emit(state.copyWith(invites: invites));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _onDeletePressed(DeletePressed event, Emitter<UserProjectsInvitesState> emit) {
    final List<ProjectInviteItem> invites = List<ProjectInviteItem>.empty(growable: true);

    try {
      _invitesRepository.deleteInviteById(event.inviteId);

      invites
        ..addAll(state.invites)
        ..removeWhere((ProjectInviteItem element) => element.id == event.inviteId);

      emit(state.copyWith(invites: invites));
    } catch (e) {
      print(e);
    }
  }

  Iterable<ProjectInviteItem> _mapInvites(List<ProjectInvite> invites, List<Project> projects, List<FullUser> users) {
    return invites.map((ProjectInvite invite) {
      final Project project = projects.firstWhere((Project element) => element.id == invite.projectId);
      final FullUser sender = users.firstWhere((FullUser element) => element.id == invite.senderUid);

      return ProjectInviteItem(invite.receiverUid, sender, project, invite.id);
    });
  }
}
