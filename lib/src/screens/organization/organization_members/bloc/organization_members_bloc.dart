import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/repository/organization/firebase_organization_repository.dart';

part 'organization_members_event.dart';

part 'organization_members_state.dart';

class OrganizationMembersBloc extends Bloc<OrganizationMembersEvent, OrganizationMembersState> {
  OrganizationMembersBloc({
    required String uid,
    required String organizationId,
  })  : _uid = uid,
        _organizationId = organizationId,
        super(const OrganizationMembersState()) {
    on<LoadData>(_onLoadData);
    on<RemoveMember>(_onRemoveMember);
  }

  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();
  final String _uid;
  final String _organizationId;

  Future<void> _onLoadData(LoadData event, Emitter<OrganizationMembersState> emit) async {
    final Organization organization = await _firebaseOrganizationRepository.getOrganizationById(_organizationId);
    final List<FullUser> membersList = List<FullUser>.empty(growable: true);
    for(final String memberId in organization.members) {
      membersList.add(await _firebaseUserRepository.getFullUserByUid(memberId));
    }
    emit(state.copyWith(
      isLoaded: true,
      isOwned: _uid == organization.ownerId,
      isMember: organization.members.contains(_uid),
      organization: organization,
      members: membersList,
    ));
  }

  Future<void> _onRemoveMember(RemoveMember event, Emitter<OrganizationMembersState> emit) async {
    emit(state.copyWith(isLoaded: false));
    await _firebaseOrganizationRepository.removeMemberByUid(_organizationId, event.memberUid);
    add(LoadData());
    //final List<FullUser> memberList = state.members;
    //memberList.removeWhere((FullUser user) => user.id == event.memberUid);
    //emit(state.copyWith(isLoaded: true, members: memberList));
  }
}
