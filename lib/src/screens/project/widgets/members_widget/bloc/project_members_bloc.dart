import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_project_repository/barrel.dart';

part 'project_members_event.dart';

part 'project_members_state.dart';

class ProjectMembersBloc extends Bloc<ProjectMembersEvent, ProjectMembersState> {
  ProjectMembersBloc(FirebaseProjectRepository projectRepository)
      : _projectRepository = projectRepository,
        super(const ProjectMembersState()) {
    on<DeleteMemberPressed>(_deleteMemberPressed);
    on<SetMembers>(_setMembers);
  }

  final FirebaseProjectRepository _projectRepository;

  FutureOr<void> _deleteMemberPressed(DeleteMemberPressed event, Emitter<ProjectMembersState> emit) {
    try {
      _projectRepository.deleteMemberFromProject(event.userId, event.projectId);
      final List<FullUser> users = state.users.toList();

      users.removeWhere((FullUser element) => element.id == event.userId);
      print("users $users ");
      emit(state.copyWith(users: users));
    } catch (e) {
      print('_deleteMemberPressed $e');
    }
  }

  FutureOr<void> _setMembers(SetMembers event, Emitter<ProjectMembersState> emit) {
    try {
      emit(state.copyWith(users: event.users));
    } catch (e) {
      print('_setMembers $e');
    }
  }
}
