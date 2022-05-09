import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'user_projects_page_event.dart';

part 'user_projects_state.dart';

class UserProjectsBloc extends Bloc<UserProjectsEvent, UserProjectsState> {
  UserProjectsBloc(this._projectRepository) : super(const UserProjectsState()) {
    on<GetProjects>(_getProjects);
    on<ProjectTypeChanged>(_onProjectTypeChanged);
  }

  final FirebaseProjectRepository _projectRepository;

  Future<void> _getProjects(GetProjects event, Emitter<UserProjectsState> emit) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      List<Project> projects = [];
      switch (state.projectType) {
        case ProjectType.OWNED:
          projects = await _projectRepository.getOwnedProjectsByUid(event.uid);
          break;
        case ProjectType.JOINED:
          projects = await _projectRepository.getJoinedProjectsByUid(event.uid);
          break;
        case ProjectType.ALL:
          break;
      }
      emit(state.copyWith(projects: projects, status: PageStatus.success, projectType: event.projectType));
    } catch (e) {
      print('_getProjects $e');
      emit(state.copyWith(status: PageStatus.failed));
    }
  }

  FutureOr<void> _onProjectTypeChanged(ProjectTypeChanged event, Emitter<UserProjectsState> emit) {
    emit(state.copyWith(projectType: event.projectType));
    add(GetProjects(event.uid, event.projectType));
  }
}
