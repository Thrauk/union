import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_open_role_repository.dart';

part 'project_details_event.dart';

part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  ProjectDetailsBloc(this._openRoleRepository) : super(const ProjectDetailsState()) {
    on<GetOpenRoles>(_getOpenRoles);
  }

  final FirebaseProjectOpenRoleRepository _openRoleRepository;

  Future<void> _getOpenRoles(GetOpenRoles event, Emitter<ProjectDetailsState> emit) async {
    try {
      final List<ProjectOpenRole> openRoles = await _openRoleRepository.getOpenRolesByProjectId(event.projectId);
      if(openRoles != null) {
        emit(state.copyWith(openRoles));
      }
    } catch (e) {
      print('_getOpenRoles $e');
    }
  }
}