import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'project_details_event.dart';

part 'project_details_state.dart';

class ProjectDetailsBloc extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  ProjectDetailsBloc(this._openRoleRepository, this._projectRepository) : super(const ProjectDetailsState()) {
    on<GetOpenRoles>(_getOpenRoles);
    on<GetMembers>(_getMembers);
  }

  final FirebaseProjectOpenRoleRepository _openRoleRepository;
  final FirebaseProjectRepository _projectRepository;

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
      membersList = await _projectRepository.getMembers(event.projectId);

      emit(state.copyWith(membersList: membersList));
    } catch (e) {
      if (kDebugMode) {
        print('_getMembers $e');
      }
    }
  }
}
