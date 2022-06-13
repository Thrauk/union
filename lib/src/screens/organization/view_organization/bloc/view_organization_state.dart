part of 'view_organization_bloc.dart';

class ViewOrganizationState extends Equatable {
  const ViewOrganizationState({
    this.isLoaded = false,
    this.isOwned = false,
    this.isMember = false,
    this.organization = Organization.empty,
    this.projects = const <Project>[],
    this.isDeleted = false,
    this.isRequested = false,
    this.joinRequests = const <OrganizationJoinRequest>[],
  });

  final bool isLoaded;
  final bool isOwned;
  final bool isMember;
  final Organization organization;
  final List<Project> projects;
  final bool isDeleted;
  final bool isRequested;
  final List<OrganizationJoinRequest> joinRequests;

  ViewOrganizationState copyWith({
    bool? isLoaded,
    bool? isOwned,
    bool? isMember,
    Organization? organization,
    List<Project>? projects,
    bool? isDeleted,
    bool? isRequested,
    List<OrganizationJoinRequest>? joinRequests,
  }) {
    return ViewOrganizationState(
      isLoaded: isLoaded ?? this.isLoaded,
      isOwned: isOwned ?? this.isOwned,
      organization: organization ?? this.organization,
      isMember: isMember ?? this.isMember,
      projects: projects ?? this.projects,
      isDeleted: isDeleted ?? this.isDeleted,
      isRequested: isRequested ?? this.isRequested,
      joinRequests: joinRequests ?? this.joinRequests,
    );
  }

  @override
  List<Object> get props => <Object>[
        isLoaded,
        isOwned,
        isMember,
        organization,
        projects,
        isDeleted,
        isRequested,
        joinRequests,
      ];
}
