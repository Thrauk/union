part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => <Object>[];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile(this.uid);

  final String uid;

  @override
  List<Object> get props => <Object>[uid];
}

class OwnedProfile extends ProfileEvent {}

class ProfileChanged extends ProfileEvent {
  const ProfileChanged(this.user);
  final FullUser user;

  @override
  List<Object> get props => <Object>[user];
}