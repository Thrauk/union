import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'open_role_applicants_event.dart';

part 'open_role_applicants_state.dart';

class OpenRoleApplicantsBloc extends Bloc<OpenRoleApplicantsEvent, OpenRoleApplicantsState> {
  OpenRoleApplicantsBloc(this.openRoleRepository) : super(const OpenRoleApplicantsState()) {
    on<GetApplicantsList>(_getApplicationsItems);
    on<AcceptApplicationPressed>(_acceptApplicationPressed);
  }

  final FirebaseProjectOpenRoleRepository openRoleRepository;

  FutureOr<void> _getApplicationsItems(GetApplicantsList event, Emitter<OpenRoleApplicantsState> emit) async {
    try {
      final List<ProjectOpenRoleApplicationItem> applicationsItems =
          await openRoleRepository.getProjectApplicationItems(event.openRoleId);

      emit(state.copyWith(applicationsItems: applicationsItems, status: StatusEnum.successful));
    } catch (e) {
      emit(state.copyWith(status: StatusEnum.failed));
      print('_getApplicantsList $e');
    }
  }

  FutureOr<void> _acceptApplicationPressed(AcceptApplicationPressed event, Emitter<OpenRoleApplicantsState> emit) {
    try {
      openRoleRepository.acceptApplication(event.openRole, event.application);
      add(GetApplicantsList(event.openRole.id));
    } catch (e) {
      print('_acceptApplicationPressed $e');
    }
  }
}
