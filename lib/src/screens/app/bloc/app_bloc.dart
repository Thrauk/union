import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/authentication/auth.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (AppUser user) => add(AppUserChanged(user)),
    );

    _firebaseOnMessageSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    _firebaseOnMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AppUser> _userSubscription;
  late final StreamSubscription<RemoteMessage> _firebaseOnMessageSubscription;
  late final StreamSubscription<RemoteMessage> _firebaseOnMessageOpenedAppSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    print('User changed');
    print(event.user.isNotEmpty);
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _firebaseOnMessageSubscription.cancel();
    _firebaseOnMessageOpenedAppSubscription.cancel();
    return super.close();
  }
}
