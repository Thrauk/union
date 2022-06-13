part of 'view_organization_requests_bloc.dart';

class ViewOrganizationRequestsState extends Equatable {
  const ViewOrganizationRequestsState({
    this.joinRequests = const <OrganizationJoinRequest>[],
    this.userRequests = const <FullUser>[],
    this.isLoaded = false,
  });

  final List<OrganizationJoinRequest> joinRequests;
  final List<FullUser> userRequests;
  final bool isLoaded;

  ViewOrganizationRequestsState copyWith({
    List<OrganizationJoinRequest>? joinRequests,
    List<FullUser>? userRequests,
    bool? isLoaded,
  }) {
    return ViewOrganizationRequestsState(
      joinRequests: joinRequests ?? this.joinRequests,
      userRequests: userRequests ?? this.userRequests,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        joinRequests,
        userRequests,
        isLoaded,
      ];
}
