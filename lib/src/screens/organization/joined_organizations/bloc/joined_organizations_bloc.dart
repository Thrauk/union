import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/repository/organization/firebase_organization_repository.dart';

part 'joined_organizations_event.dart';

part 'joined_organizations_state.dart';

class JoinedOrganizationsBloc extends Bloc<JoinedOrganizationsEvent, JoinedOrganizationsState> {
  JoinedOrganizationsBloc({required String uid})
      : _uid = uid,
        super(const JoinedOrganizationsState()) {
    on<LoadData>(_onLoadData);
  }

  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final String _uid;

  Future<void> _onLoadData(LoadData event, Emitter<JoinedOrganizationsState> emit) async {
    List<Organization> organizationList;
    organizationList = await _firebaseOrganizationRepository.getUserOrganizations(_uid);
    emit(state.copyWith(isLoaded: true, organizationList: organizationList));
  }
}
