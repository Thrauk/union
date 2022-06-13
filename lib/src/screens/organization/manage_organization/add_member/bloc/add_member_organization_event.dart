part of 'add_member_organization_bloc.dart';

abstract class AddMemberOrganizationEvent extends Equatable {
  const AddMemberOrganizationEvent();

  @override
  List<Object> get props => <Object>[];
}

class SearchPressed extends AddMemberOrganizationEvent {}

class SearchValueChanged extends AddMemberOrganizationEvent {
  const SearchValueChanged({required this.value});

  final String value;
}

class AddMemberPressed extends AddMemberOrganizationEvent {
  const AddMemberPressed({required this.memberId});

  final String memberId;
}

class LoadOrganization extends AddMemberOrganizationEvent {
  const LoadOrganization({required this.organizationId});

  final String organizationId;
}
