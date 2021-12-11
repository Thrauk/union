part of 'profile_bloc.dart';

enum ProfileType { myProfile, otherProfile }

class ProfileState extends Equatable {
  const ProfileState({this.fullUser = FullUser.empty, this.ownProfile = false});

  final FullUser fullUser;
  final bool ownProfile;

  ProfileState copyWith({FullUser? fullUser, bool? ownProfile}) {
    return ProfileState(
      fullUser: fullUser ?? this.fullUser,
      ownProfile: ownProfile ?? this.ownProfile,
    );
  }

  @override
  List<Object> get props => <Object>[fullUser];
}
