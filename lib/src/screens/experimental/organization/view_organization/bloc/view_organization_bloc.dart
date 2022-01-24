import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/screens/experimental/models/organization.dart';
import 'package:union_app/src/screens/experimental/repository/organization/firebase_organization_repository.dart';

part 'view_organization_event.dart';

part 'view_organization_state.dart';

class ViewOrganizationBloc extends Bloc<ViewOrganizationEvent, ViewOrganizationState> {
  ViewOrganizationBloc({
    required String uid,
    required String organizationId,
  })  : _uid = uid,
        _organizationId = organizationId,
        super(const ViewOrganizationState()) {
    on<LoadData>(_onLoadData);
    on<JoinOrganization>(_onJoinOrganization);
    on<LeaveOrganization>(_onLeaveOrganization);
  }

  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final String _uid;
  final String _organizationId;

  Future<void> _onLoadData(LoadData event, Emitter<ViewOrganizationState> emit) async {
    final Organization organization = await _firebaseOrganizationRepository.getOrganizationById(_organizationId);
    emit(state.copyWith(
      isLoaded: true,
      isOwned: _uid == organization.ownerId,
      isMember: organization.members.contains(_uid),
      organization: organization,
    ));
  }

  Future<void> _onJoinOrganization(JoinOrganization event, Emitter<ViewOrganizationState> emit) async {
    if(!state.isMember) {
      final bool response = await _firebaseOrganizationRepository.joinOrganization(state.organization.id, _uid);
      emit(state.copyWith(isMember: response));
    }

  }

  Future<void> _onLeaveOrganization(LeaveOrganization event, Emitter<ViewOrganizationState> emit) async {
    if(state.isMember) {
      final bool response = await _firebaseOrganizationRepository.leaveOrganization(state.organization.id, _uid);
      emit(state.copyWith(isMember: response ? false : true));
    }
  }

}
