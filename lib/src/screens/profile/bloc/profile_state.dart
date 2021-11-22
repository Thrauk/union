part of 'profile_bloc.dart';

enum ProfileType { myProfile, otherProfile }

class ProfileState extends Equatable {
  const ProfileState({this.fullUser = FullUser.empty});

  final FullUser fullUser;

  ProfileState copyWith({FullUser? fullUser}) {
    return ProfileState(
      fullUser: fullUser ?? this.fullUser,
    );
  }

  @override
  List<Object> get props => <Object>[fullUser];
}
