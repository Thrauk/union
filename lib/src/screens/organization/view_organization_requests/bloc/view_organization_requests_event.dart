part of 'view_organization_requests_bloc.dart';

class ViewOrganizationRequestsEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class LoadData extends ViewOrganizationRequestsEvent {}

class AcceptRequest extends ViewOrganizationRequestsEvent {
  AcceptRequest({required this.joinRequest});
  final OrganizationJoinRequest joinRequest;
}

class DenyRequest extends ViewOrganizationRequestsEvent {
  DenyRequest({required this.joinRequest});
  final OrganizationJoinRequest joinRequest;
}