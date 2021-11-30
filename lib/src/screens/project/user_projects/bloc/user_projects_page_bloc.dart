import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';

part 'user_projects_page_event.dart';

part 'user_projects_page_state.dart';

class UserProjectsPageBloc
    extends Bloc<UserProjectsPageEvent, UserProjectsPageState> {
  UserProjectsPageBloc(this._projectRepository)
      : super(const UserProjectsPageState()) {
    on<GetProjects>(_getProjects);
  }

  final FirebaseProjectRepository _projectRepository;

  Future<void> _getProjects(
      GetProjects event, Emitter<UserProjectsPageState> emit) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final List<Project> projects =
          await _projectRepository.getProjectsByUid(event.uid);
      emit(state.copyWith(projects: projects, status: PageStatus.success));
    } catch (e) {
      print('_getProjects $e');
      emit(state.copyWith(status: PageStatus.failed));
    }
  }
}
