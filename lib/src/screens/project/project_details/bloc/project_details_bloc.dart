import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/github/github_repository_item.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_project_repository/firebase_project_members_repository.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/repository/github/github_repository.dart';

part 'project_details_event.dart';

part 'project_details_state.dart';

class ProjectDetailsBloc extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  ProjectDetailsBloc(this._openRoleRepository, this._projectMembersRepository, this._githubRepository)
      : super(const ProjectDetailsState()) {
    on<GetOpenRoles>(_getOpenRoles);
    on<GetMembers>(_getMembers);
    on<GetLinkedRepository>(_getLinkedRepository);
  }

  final FirebaseProjectOpenRoleRepository _openRoleRepository;
  final FirebaseProjectMembersRepository _projectMembersRepository;
  final GithubRepository _githubRepository;

  Future<void> _getOpenRoles(GetOpenRoles event, Emitter<ProjectDetailsState> emit) async {
    try {
      final List<ProjectOpenRole> openRoles = await _openRoleRepository.getOpenRolesByProjectId(event.projectId);
      if (openRoles != null) {
        emit(state.copyWith(openRoles: openRoles));
      }
    } catch (e) {
      print('_getOpenRoles $e');
    }
  }

  Future<FutureOr<void>> _getMembers(GetMembers event, Emitter<ProjectDetailsState> emit) async {
    try {
      final List<FullUser> membersList;
      membersList = await _projectMembersRepository.getMembers(event.projectId);

      emit(state.copyWith(membersList: membersList));
    } catch (e) {
      if (kDebugMode) {
        print('_getMembers $e');
      }
    }
  }

  Future<FutureOr<void>> _getLinkedRepository(GetLinkedRepository event, Emitter<ProjectDetailsState> emit) async {
    try {
      if (event.repositoryName.isNotEmpty) {
        final GithubRepositoryItem repository = await _githubRepository.getGithubRepository(event.repositoryName);
        print(repository.fullName);
        emit(state.copyWith(githubRepositoryItem: repository));
      }
    } catch (e) {
      print(e);
    }
  }
}
