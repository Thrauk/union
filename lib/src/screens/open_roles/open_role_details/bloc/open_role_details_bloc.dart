import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';

part 'open_role_details_event.dart';

part 'open_role_details_state.dart';

class OpenRoleDetailsBloc
    extends Bloc<OpenRoleDetailsEvent, OpenRoleDetailsState> {
  OpenRoleDetailsBloc(this.firebaseProjectRepository)
      : super(const OpenRoleDetailsState()) {
    on<GetProjectDetails>(_getProjectDetails);
  }

  FirebaseProjectRepository firebaseProjectRepository;

  Future<void> _getProjectDetails(
      GetProjectDetails event, Emitter<OpenRoleDetailsState> emit) async {
    try {
      final Project? project =
          await firebaseProjectRepository.getProjectById(event.projectId);
      if (project != null) {
        emit(state.copyWith(project: project));
        print(project.toString());
      }
    } catch (e) {
      print('_getProjectDetails $e');
    }
  }
}
