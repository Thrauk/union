part of 'view_organization_bloc.dart';

class ViewOrganizationState extends Equatable {
  const ViewOrganizationState({
    this.isLoaded = false,
    this.isOwned = false,
    this.organization = Organization.empty,
  });

  final bool isLoaded;
  final bool isOwned;
  final Organization organization;

  ViewOrganizationState copyWith({
    bool? isLoaded,
    bool? isOwned,
    Organization? organization,
  }) {
    return ViewOrganizationState(
      isLoaded: isLoaded ?? this.isLoaded,
      isOwned: isOwned ?? this.isOwned,
      organization: organization ?? this.organization,
    );
  }

  @override
  List<Object> get props => <Object>[
        isLoaded,
        isOwned,
        organization,
      ];
}
