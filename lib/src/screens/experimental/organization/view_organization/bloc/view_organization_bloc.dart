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
  }

  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final String _uid;
  final String _organizationId;

  Future<void> _onLoadData(LoadData event, Emitter<ViewOrganizationState> emit) async {
    final Organization organization = await _firebaseOrganizationRepository.getOrganizationById(_organizationId);
    emit(state.copyWith(
      isLoaded: true,
      isOwned: _uid == organization.ownerId,
      organization: organization,
    ));
  }
}
