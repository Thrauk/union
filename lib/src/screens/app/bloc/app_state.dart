part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = AppUser.empty,
    this.userDetails = FullUser.empty,
  });

  const AppState.authenticated(AppUser user) : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated, user: AppUser.empty);

  final AppStatus status;
  final AppUser user;
  final FullUser userDetails;

  AppState copyWith({
    AppStatus? status,
    AppUser? user,
    FullUser? userDetails,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
      userDetails: userDetails ?? this.userDetails,
    );
  }

  @override
  List<Object> get props => <Object>[status, user, userDetails];
}
