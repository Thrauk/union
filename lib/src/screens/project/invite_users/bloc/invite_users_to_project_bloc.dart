import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_user/barrel.dart';

part 'invite_users_to_project_event.dart';

part 'invite_users_to_project_state.dart';

class InviteUsersToProjectBloc extends Bloc<InviteUsersToProjectEvent, InviteUsersToProjectState> {
  InviteUsersToProjectBloc() : super(const InviteUsersToProjectState()) {
    on<TextChanged>(_onTextChanged);
    on<SearchIconPressed>(_onSearchIconPressed);
    on<InvitePressed>(_onRequestUserPressed);
  }

  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();

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

  FutureOr<void> _onRequestUserPressed(InvitePressed event, Emitter<InviteUsersToProjectState> emit) {}
}
