part of 'organization_members_bloc.dart';

abstract class OrganizationMembersEvent extends Equatable {
  const OrganizationMembersEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadData extends OrganizationMembersEvent {}

