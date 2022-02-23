import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/repository/organization/firebase_organization_repository.dart';

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
    on<DeleteOrganization>(_onDeleteOrganization);
  }

  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final FirebaseProjectRepository _firebaseProjectRepository = FirebaseProjectRepository();
  final String _uid;
  final String _organizationId;

  Future<void> _onLoadData(LoadData event, Emitter<ViewOrganizationState> emit) async {
    final Organization organization = await _firebaseOrganizationRepository.getOrganizationById(_organizationId);
    final List<Project> projectList = await _firebaseProjectRepository.getProjectsOrganization(20, _organizationId);
    projectList.sort((Project A, Project B) => B.timestamp.compareTo(A.timestamp));
    emit(state.copyWith(
      isLoaded: true,
      isOwned: _uid == organization.ownerId,
      isMember: organization.members.contains(_uid),
      organization: organization,
      projects: projectList,
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

  Future<void> _onDeleteOrganization(DeleteOrganization event, Emitter<ViewOrganizationState> emit) async {
    if(state.isOwned) {
      await _firebaseOrganizationRepository.deleteOrganization(state.organization.id);
      emit(state.copyWith(isDeleted: true));
    }
  }

}
