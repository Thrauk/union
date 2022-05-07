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
    on<RequestJoin>(_onRequestJoin);
  }

  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final FirebaseProjectRepository _firebaseProjectRepository = FirebaseProjectRepository();
  final String _uid;
  final String _organizationId;

  Future<void> _onLoadData(LoadData event, Emitter<ViewOrganizationState> emit) async {
    final Organization organization = await _firebaseOrganizationRepository.getOrganizationById(_organizationId);
    final bool isOwned = _uid == organization.ownerId;
    final bool isMember = organization.members.contains(_uid);

    bool isRequested = false;

    if (!isOwned && !isMember) {
      isRequested = await _firebaseOrganizationRepository.isJoinRequested(_organizationId, _uid);
      emit(state.copyWith(
        isLoaded: true,
        isOwned: isOwned,
        isMember: isMember,
        organization: organization,
        isRequested: isRequested,
      ));
    } else {
      List<OrganizationJoinRequest>? joinRequests;
      final List<Project> projectList = await _firebaseProjectRepository.getProjectsOrganization(20, _organizationId);
      projectList.sort((Project A, Project B) => B.timestamp.compareTo(A.timestamp));

      if (isOwned) {
        joinRequests = await _firebaseOrganizationRepository.getAllJoinOrganizationRequests(_organizationId);
      }

      emit(state.copyWith(
        isLoaded: true,
        isOwned: isOwned,
        isMember: isMember,
        organization: organization,
        projects: projectList,
        joinRequests: joinRequests,
      ));
    }
  }

  Future<void> _onRequestJoin(RequestJoin event, Emitter<ViewOrganizationState> emit) async {
    if (!state.isMember) {
      if (state.isRequested) {
        await _firebaseOrganizationRepository.removeJoinOrganizationRequest(_organizationId, _uid);
        emit(state.copyWith(isRequested: false));
      } else {
        final OrganizationJoinRequest joinRequest = OrganizationJoinRequest(
          uid: _uid,
          organizationId: _organizationId,
          timestamp: DateTime.now().microsecondsSinceEpoch,
        );
        await _firebaseOrganizationRepository.requestJoinOrganization(joinRequest);
        emit(state.copyWith(isRequested: true));
      }
    }
  }

  Future<void> _onJoinOrganization(JoinOrganization event, Emitter<ViewOrganizationState> emit) async {
    if (!state.isMember) {
      final bool response = await _firebaseOrganizationRepository.joinOrganization(state.organization.id, _uid);
      emit(state.copyWith(isMember: response));
    }
  }

  Future<void> _onLeaveOrganization(LeaveOrganization event, Emitter<ViewOrganizationState> emit) async {
    if (state.isMember) {
      final bool response = await _firebaseOrganizationRepository.leaveOrganization(state.organization.id, _uid);
      emit(state.copyWith(isMember: response ? false : true));
    }
  }

  Future<void> _onDeleteOrganization(DeleteOrganization event, Emitter<ViewOrganizationState> emit) async {
    if (state.isOwned) {
      await _firebaseOrganizationRepository.deleteOrganization(state.organization.id);
      emit(state.copyWith(isDeleted: true));
    }
  }
}
