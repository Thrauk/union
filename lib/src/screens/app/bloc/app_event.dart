part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => <Object>[];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final AppUser user;

  @override
  List<Object> get props => <Object>[user];
}

class AppUserLoggedIn extends AppEvent {
  const AppUserLoggedIn(this.user);
  final AppUser user;
  @override
  List<Object> get props => <Object>[user];

}

class UserDetailsChanged extends AppEvent {
  const UserDetailsChanged(this.userDetails);
  final FullUser userDetails;
  @override
  List<Object> get props => <Object>[userDetails];
}

