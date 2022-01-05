part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = AppUser.empty,
  });

  const AppState.authenticated(AppUser user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated, user: AppUser.empty);

  final AppStatus status;
  final AppUser user;

  @override
  List<Object> get props => <Object>[status, user];
}
