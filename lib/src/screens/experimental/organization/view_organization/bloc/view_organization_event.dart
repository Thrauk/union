part of 'view_organization_bloc.dart';

abstract class ViewOrganizationEvent extends Equatable {
  const ViewOrganizationEvent();
  @override
  List<Object> get props => <Object>[];
}

class LoadData extends ViewOrganizationEvent {}

class JoinOrganization extends ViewOrganizationEvent {}
class LeaveOrganization extends ViewOrganizationEvent {}
