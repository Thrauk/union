import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'view_user_applications_event.dart';
part 'view_user_applications_state.dart';

class ViewUserApplicationsBloc extends Bloc<ViewUserApplicationsEvent, ViewUserApplicationsState> {
  ViewUserApplicationsBloc(this._applicationsRepository) : super(const ViewUserApplicationsState()) {
    on<GetApplications>(_getApplications);
  }

  final FirebaseOpenRoleApplicationsRepository _applicationsRepository;

  Future<FutureOr<void>> _getApplications(GetApplications event, Emitter<ViewUserApplicationsState> emit) async {
    try {
      final List<ProjectOpenRole> openRoles = await _applicationsRepository.getUserApplications(event.uid);
      emit(state.copyWith(openRoles: openRoles, status: PageStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PageStatus.failed));
      // developer.log('_getApplications $e');
    }
  }
}
