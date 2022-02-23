import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'open_role_details_event.dart';

part 'open_role_details_state.dart';

class OpenRoleDetailsBloc extends Bloc<OpenRoleDetailsEvent, OpenRoleDetailsState> {
  OpenRoleDetailsBloc(this.firebaseProjectRepository, this.firebaseProjectOpenRoleRepository)
      : super(const OpenRoleDetailsState()) {
    on<GetProjectDetails>(_getProjectDetails);
    on<ApplyButtonPressed>(_applyButtonPressed);
    on<VerifyIfUserAlreadyApplied>(_verifyIfUserAlreadyApplied);
  }

  FirebaseProjectRepository firebaseProjectRepository;
  FirebaseProjectOpenRoleRepository firebaseProjectOpenRoleRepository;

  Future<void> _getProjectDetails(GetProjectDetails event, Emitter<OpenRoleDetailsState> emit) async {
    try {
      final Project? project = await firebaseProjectRepository.getProjectById(event.projectId);
      if (project != null) {
        emit(state.copyWith(project: project));
      }
    } catch (e) {
      print('_getProjectDetails $e');
    }
  }

  Future<void> _applyButtonPressed(ApplyButtonPressed event, Emitter<OpenRoleDetailsState> emit) async {
    try {
      if (state.alreadyAppliedToProject)
        await firebaseProjectOpenRoleRepository.deleteUidFromOpenRole(
          event.openRoleId,
          ProjectOpenRoleApplication(uid: event.uid),
        );
      add(VerifyIfUserAlreadyApplied(event.uid, event.openRoleId));
    } catch (e) {
      print('_applyButtonPressed $e');
    }
  }

  Future<FutureOr<void>> _verifyIfUserAlreadyApplied(
      VerifyIfUserAlreadyApplied event, Emitter<OpenRoleDetailsState> emit) async {
    try {
      final bool? hasAlreadyApplied = await firebaseProjectOpenRoleRepository.isUidAlreadyAdded(event.uid, event.openRoleId);
      print('_verifyIfUserAlreadyApplied $hasAlreadyApplied');
      if (hasAlreadyApplied != null) {
        emit(state.copyWith(alreadyAppliedToProject: hasAlreadyApplied));
      }
    } catch (e) {
      print('_verifyIfUserAlreadyApplied $e');
    }
  }
}
