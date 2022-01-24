part of 'view_organization_bloc.dart';

class ViewOrganizationState extends Equatable {
  const ViewOrganizationState({
    this.isLoaded = false,
    this.isOwned = false,
    this.isMember = false,
    this.organization = Organization.empty,
  });

  final bool isLoaded;
  final bool isOwned;
  final bool isMember;
  final Organization organization;

  ViewOrganizationState copyWith({
    bool? isLoaded,
    bool? isOwned,
    bool? isMember,
    Organization? organization,
  }) {
    return ViewOrganizationState(
      isLoaded: isLoaded ?? this.isLoaded,
      isOwned: isOwned ?? this.isOwned,
      organization: organization ?? this.organization,
      isMember: isMember ?? this.isMember,
    );
  }

  @override
  List<Object> get props => <Object>[
        isLoaded,
        isOwned,
        isMember,
        organization,
      ];
}
