import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_project_repository/firebase_project_invites_repository.dart';
import 'package:union_app/src/repository/firestore/firebase_user/barrel.dart';

part 'invite_users_to_project_event.dart';

part 'invite_users_to_project_state.dart';

class InviteUsersToProjectBloc extends Bloc<InviteUsersToProjectEvent, InviteUsersToProjectState> {
  InviteUsersToProjectBloc() : super(const InviteUsersToProjectState()) {
    on<TextChanged>(_onTextChanged);
    on<SearchIconPressed>(_onSearchIconPressed);
    on<DismissPressed>(_onDismissPressed);
    on<InvitePressed>(_onInvitePressed);
    on<GetProjectInvites>(_onGetProjectInvites);
  }

  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();
  final FirebaseProjectInvitesRepository _firebaseProjectInvitesRepository = FirebaseProjectInvitesRepository();

  FutureOr<void> _onTextChanged(TextChanged event, Emitter<InviteUsersToProjectState> emit) {
    emit(state.copyWith(query: event.value));
  }

  // TODO(amalia): to be modified
  Future<FutureOr<void>> _onSearchIconPressed(SearchIconPressed event, Emitter<InviteUsersToProjectState> emit) async {
    try {
      if (state.query.isNotEmpty) {
        final List<FullUser> users = await _firebaseUserRepository.getAllUsers();

        final List<FullUser> filteredUsers = users
            .where((FullUser user) =>
                user.displayName!.contains(state.query) ||
                (user.jobTitle ?? '').contains(state.query) ||
                (user.location ?? '').contains(state.query))
            .toList();

        emit(state.copyWith(resultedUsers: filteredUsers, pageStatus: PageStatus.FINAL));
      }
    } catch (e) {
      emit(state.copyWith(pageStatus: PageStatus.FAILED));
      print(e);
    }
  }

  FutureOr<void> _onInvitePressed(InvitePressed event, Emitter<InviteUsersToProjectState> emit) {
    try {
      final List<String> invitedUsers = List<String>.empty(growable: true);
      _firebaseProjectInvitesRepository.createInvite(event.senderUid, event.receiverUid, event.projectId);

      invitedUsers
        ..addAll(state.invitedUsersUids)
        ..add(event.receiverUid);

      emit(state.copyWith(invitedUsersUids: invitedUsers));
    } catch (e) {
      print(e);
    }
  }

  Future<FutureOr<void>> _onGetProjectInvites(GetProjectInvites event, Emitter<InviteUsersToProjectState> emit) async {
    try {
      final List<ProjectInvite> projectInvites = await _firebaseProjectInvitesRepository.getProjectsInvites(event.projectId);
      final List<String> invitedUsers = projectInvites.map((ProjectInvite e) => e.receiverUid).toList();

      emit(state.copyWith(invitedUsersUids: invitedUsers));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _onDismissPressed(DismissPressed event, Emitter<InviteUsersToProjectState> emit) {
      final List<String> invitedUsers = List<String>.empty(growable: true);
      _firebaseProjectInvitesRepository.deleteInviteByProjectAndReceiverIds(event.projectId, event.receiverUid);

      invitedUsers
        ..addAll(state.invitedUsersUids)
        ..removeWhere((String element) => element == event.receiverUid);

      emit(state.copyWith(invitedUsersUids: invitedUsers));

  }
}
