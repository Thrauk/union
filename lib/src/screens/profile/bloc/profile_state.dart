part of 'profile_bloc.dart';

enum ProfileType { myProfile, otherProfile }

class ProfileState extends Equatable {
  const ProfileState({this.fullUser = FullUser.empty, this.editable = false});

  final FullUser fullUser;
  final bool editable;

  ProfileState copyWith({FullUser? fullUser, bool? editable}) {
    return ProfileState(
      fullUser: fullUser ?? this.fullUser,
      editable: editable ?? this.editable,
    );
  }

  @override
  List<Object> get props => <Object>[fullUser];
}
