part of 'profile_bloc.dart';

enum ProfileType { myProfile, otherProfile }

enum SelectedPosts { project, article }

class ProfileState extends Equatable {
  const ProfileState({
    this.fullUser = FullUser.empty,
    this.ownProfile = false,
    this.followsUser = false,
    this.selectedPosts = SelectedPosts.project,
  });

  final FullUser fullUser;
  final bool ownProfile;
  final bool followsUser;
  final SelectedPosts selectedPosts;

  ProfileState copyWith({
    FullUser? fullUser,
    bool? ownProfile,
    bool? followsUser,
    SelectedPosts? selectedPosts,
  }) {
    return ProfileState(
      fullUser: fullUser ?? this.fullUser,
      ownProfile: ownProfile ?? this.ownProfile,
      followsUser: followsUser ?? this.followsUser,
      selectedPosts: selectedPosts ?? this.selectedPosts,
    );
  }

  @override
  List<Object> get props => <Object>[
        fullUser,
        followsUser,
        selectedPosts,
      ];
}
