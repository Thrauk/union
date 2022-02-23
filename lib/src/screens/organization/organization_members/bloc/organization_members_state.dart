part of 'organization_members_bloc.dart';

class OrganizationMembersState extends Equatable {
  const OrganizationMembersState({
    this.isLoaded = false,
    this.isOwned = false,
    this.isMember = false,
    this.organization = Organization.empty,
    this.members = const <FullUser>[],
  });

  final bool isLoaded;
  final bool isOwned;
  final bool isMember;
  final Organization organization;
  final List<FullUser> members;

  OrganizationMembersState copyWith({
    bool? isLoaded,
    bool? isOwned,
    bool? isMember,
    Organization? organization,
    List<FullUser>? members,
  }) {
    return OrganizationMembersState(
      isLoaded: isLoaded ?? this.isLoaded,
      isOwned: isOwned ?? this.isOwned,
      organization: organization ?? this.organization,
      isMember: isMember ?? this.isMember,
      members: members ?? this.members,
    );
  }

  @override
  List<Object> get props => <Object>[
    isLoaded,
    isOwned,
    isMember,
    organization,
    members,
  ];
}
