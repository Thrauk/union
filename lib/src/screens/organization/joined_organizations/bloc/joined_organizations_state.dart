part of 'joined_organizations_bloc.dart';

class JoinedOrganizationsState extends Equatable {
  const JoinedOrganizationsState({
    this.isLoaded = false,
    this.organizationList = const <Organization>[],
  });

  final bool isLoaded;
  final List<Organization> organizationList;

  JoinedOrganizationsState copyWith({bool? isLoaded, List<Organization>? organizationList}) {
    return JoinedOrganizationsState(
      isLoaded: isLoaded ?? this.isLoaded,
      organizationList: organizationList ?? this.organizationList,
    );
  }

  @override
  List<Object> get props => <Object>[
        isLoaded,
        organizationList,
      ];
}
