part of 'organization_members_bloc.dart';

abstract class OrganizationMembersEvent extends Equatable {
  const OrganizationMembersEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadData extends OrganizationMembersEvent {}

class RemoveMember extends OrganizationMembersEvent {
  const RemoveMember({required this.memberUid});

  final String memberUid;

  @override
  List<Object> get props => <Object>[memberUid];
}
