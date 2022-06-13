part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => <Object>[];
}

class LoadProfile extends ProfileEvent {}

class OwnedProfile extends ProfileEvent {}

class FollowOrUnfollow extends ProfileEvent {}

class ProfileChanged extends ProfileEvent {
  const ProfileChanged(this.user);
  final FullUser user;

  @override
  List<Object> get props => <Object>[user];
}

class SelectedProjectsPosts extends ProfileEvent {}

class SelectedArticlesPosts extends ProfileEvent {}