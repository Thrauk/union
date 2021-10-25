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
