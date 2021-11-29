part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState({this.fullUser = FullUser.empty});

  final FullUser fullUser;

  EditProfileState copyWith({FullUser? fullUser}) {
    return EditProfileState(
      fullUser: fullUser ?? this.fullUser,
    );
  }

  @override
  List<Object> get props => <Object>[fullUser];
}
