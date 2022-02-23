import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/repository/organization/firebase_organization_repository.dart';

part 'add_member_organization_event.dart';
part 'add_member_organization_state.dart';

class AddMemberOrganizationBloc extends Bloc<AddMemberOrganizationEvent, AddMemberOrganizationState> {
  AddMemberOrganizationBloc({
    required String organizationId,
    required String uid,
  })  : _organizationId = organizationId,
        _uid = uid,
        super(const AddMemberOrganizationState()) {
    on<SearchPressed>(_onSearchPressed);
    on<AddMemberPressed>(_onAddMemberPressed);
    on<SearchValueChanged>(_onSearchValueChanged);
    on<LoadOrganization>(_onLoadOrganization);
  }

  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();
  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final String _organizationId;
  final String _uid;

  Future<void> _onLoadOrganization(LoadOrganization event, Emitter<AddMemberOrganizationState> emit) async {
    final Organization organization = await _firebaseOrganizationRepository.getOrganizationById(event.organizationId);
    emit(state.copyWith(
      isOrganizationLoaded: true,
      organization: organization,
    ));
  }

  Future<void> _onSearchPressed(SearchPressed event, Emitter<AddMemberOrganizationState> emit) async {
    emit(state.copyWith(isLoaded: false));
    final List<FullUser> users = await _firebaseUserRepository.getAllUsers();
    final List<FullUser> filteredUsers = users
        .where((FullUser user) =>
            user.displayName!.contains(state.searchValue) ||
            (user.jobTitle ?? '').contains(state.searchValue) ||
            (user.location ?? '').contains(state.searchValue))
        .toList();
    emit(state.copyWith(isLoaded: true, userList: filteredUsers));
  }

  Future<void> _onAddMemberPressed(AddMemberPressed event, Emitter<AddMemberOrganizationState> emit) async {
    if (event.memberId != _uid && !state.organization.members.contains(event.memberId)) {
      final bool response = await _firebaseOrganizationRepository.addMemberByUid(_organizationId, event.memberId);
      if (response) {
        final List<String> members = <String>[event.memberId, ...state.organization.members];
        emit(
          state.copyWith(
            organization: state.organization.copyWith(
              members: members,
            ),
          ),
        );
      }
    }
  }

  void _onSearchValueChanged(SearchValueChanged event, Emitter<AddMemberOrganizationState> emit) {
    emit(state.copyWith(searchValue: event.value));
  }
}
