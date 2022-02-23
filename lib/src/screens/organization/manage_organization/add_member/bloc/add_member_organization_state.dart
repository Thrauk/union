part of 'add_member_organization_bloc.dart';

class AddMemberOrganizationState extends Equatable {
  const AddMemberOrganizationState({
    this.isLoaded = true,
    this.isOrganizationLoaded = false,
    this.organization = Organization.empty,
    this.userList = const <FullUser>[],
    this.searchValue = '',
  });

  final bool isLoaded;
  final List<FullUser> userList;
  final Organization organization;
  final bool isOrganizationLoaded;
  final String searchValue;

  AddMemberOrganizationState copyWith({
    bool? isLoaded,
    List<FullUser>? userList,
    String? searchValue,
    bool? isOrganizationLoaded,
    Organization? organization,
  }) {
    return AddMemberOrganizationState(
      isLoaded: isLoaded ?? this.isLoaded,
      userList: userList ?? this.userList,
      searchValue: searchValue ?? this.searchValue,
      organization: organization ?? this.organization,
      isOrganizationLoaded: isOrganizationLoaded ?? this.isOrganizationLoaded,
    );
  }

  @override
  List<Object> get props => <Object>[
        isLoaded,
        userList,
        organization,
        isOrganizationLoaded,
        searchValue,
      ];
}
