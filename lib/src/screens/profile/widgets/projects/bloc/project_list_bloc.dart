import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/project.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/repository/storage/firebase_user/firebase_user.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc({required String uid}) : _uid = uid, super(const ProjectListState()) {
    on<Initialize>(_onInitialize);
    add(Initialize());
  }
  final String _uid;
  final FirebaseProjectRepository _firebaseProjectRepository = FirebaseProjectRepository();
  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();

  Future<void> _onInitialize(Initialize event, Emitter<ProjectListState> emit) async {
    final List<Project> projectList = await _firebaseProjectRepository.getQueryProjectsByUid(_uid);
    final FullUser user = await _firebaseUserRepository.getFullUserByUid(_uid);
    emit(state.copyWith(projectList: projectList, loaded: true, user: user),
    );
  }


}
