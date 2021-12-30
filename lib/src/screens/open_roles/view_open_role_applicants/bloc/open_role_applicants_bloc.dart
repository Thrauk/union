import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_open_role_repository.dart';

part 'open_role_applicants_event.dart';
part 'open_role_applicants_state.dart';

class OpenRoleApplicantsBloc extends Bloc<OpenRoleApplicantsEvent, OpenRoleApplicantsState> {
  OpenRoleApplicantsBloc(this.openRoleRepository) : super(const OpenRoleApplicantsState()) {
    on<GetApplicantsList>(_getApplicantsList);
  }

  final FirebaseProjectOpenRoleRepository openRoleRepository;

  FutureOr<void> _getApplicantsList(GetApplicantsList event, Emitter<OpenRoleApplicantsState> emit) async {
    try {
      final List<FullUser> userList = await openRoleRepository.getFullUsersListByOpenRole(event.openRoleId);
      if(userList.isNotEmpty)
        emit(state.copyWith(usersList: userList));
    } catch (e) {
      print('_getApplicantsList $e');
    }
  }
}
