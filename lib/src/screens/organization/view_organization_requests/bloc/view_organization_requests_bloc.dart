import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_user/barrel.dart';
import 'package:union_app/src/repository/organization/firebase_organization_repository.dart';

part 'view_organization_requests_event.dart';

part 'view_organization_requests_state.dart';

class ViewOrganizationRequestsBloc extends Bloc<ViewOrganizationRequestsEvent, ViewOrganizationRequestsState> {
  ViewOrganizationRequestsBloc({required this.organizationId}) : super(const ViewOrganizationRequestsState()) {
    on<LoadData>(_onLoadData);
    on<AcceptRequest>(_onAcceptRequest);
    on<DenyRequest>(_onDenyRequest);
  }

  final String organizationId;
  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();

  Future<void> _onLoadData(LoadData event, Emitter<ViewOrganizationRequestsState> emit) async {
    final List<OrganizationJoinRequest> joinRequests =
        await _firebaseOrganizationRepository.getAllJoinOrganizationRequests(organizationId);

    final List<String> uids = joinRequests.map((OrganizationJoinRequest user) => user.uid).toList();
    final List<FullUser> users = await _firebaseUserRepository.queryUsersByUids(uids);

    emit(state.copyWith(
      isLoaded: true,
      joinRequests: joinRequests,
      userRequests: users,
    ));
  }

  Future<void> _onAcceptRequest(AcceptRequest event, Emitter<ViewOrganizationRequestsState> emit) async {
    final String organizationId = event.joinRequest.organizationId;
    final String uid = event.joinRequest.uid;
    await _firebaseOrganizationRepository.removeJoinOrganizationRequest(organizationId, uid);
    await _firebaseOrganizationRepository.addMemberByUid(organizationId, uid);
    add(LoadData());
  }

  Future<void> _onDenyRequest(DenyRequest event, Emitter<ViewOrganizationRequestsState> emit) async {
    final String organizationId = event.joinRequest.organizationId;
    final String uid = event.joinRequest.uid;
    await _firebaseOrganizationRepository.removeJoinOrganizationRequest(organizationId, uid);
    add(LoadData());

  }

}
