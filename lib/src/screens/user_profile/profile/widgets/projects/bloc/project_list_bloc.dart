import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/project/project.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'project_list_event.dart';

part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc({required String uid})
      : _uid = uid,
        super(const ProjectListState()) {
    on<Initialize>(_onInitialize);
  }

  final String _uid;
  final FirebaseProjectRepository _firebaseProjectRepository = FirebaseProjectRepository();

  Future<void> _onInitialize(Initialize event, Emitter<ProjectListState> emit) async {
    final List<Project> projectList = await _firebaseProjectRepository.getOwnedProjectsByUid(_uid);
    projectList.removeWhere((Project project) => project.organizationId != '');
    emit(
      state.copyWith(projectList: projectList, loaded: true),
    );
  }
}
