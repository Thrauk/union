part of 'profile_bloc.dart';

enum ProfileType { myProfile, otherProfile }

class ProfileState extends Equatable {
  const ProfileState({this.fullUser = FullUser.empty, this.ownProfile = false, this.followsUser = false});

  final FullUser fullUser;
  final bool ownProfile;
  final bool followsUser;

  ProfileState copyWith({FullUser? fullUser, bool? ownProfile, bool? followsUser}) {
    return ProfileState(
      fullUser: fullUser ?? this.fullUser,
      ownProfile: ownProfile ?? this.ownProfile,
      followsUser: followsUser ?? this.followsUser,
    );
  }

  @override
  List<Object> get props => <Object>[fullUser, followsUser];
}
