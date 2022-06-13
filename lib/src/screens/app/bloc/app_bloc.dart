import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/repository/notification/notification_repository.dart';

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
    on<AppUserLoggedIn>(_onAppUserLoggedIn);
    on<UserDetailsChanged>(_onUserDetailsChanged);
    _userSubscription = _authenticationRepository.user.listen(
      (AppUser user) => add(AppUserChanged(user)),
    );

    _firebaseOnMessageSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if(event.notification != null) {
        _notificationRepository.showNotification(event.notification!);
      }
    });
    _firebaseOnMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // NOT YET IMPLEMENTED
      // print(message.notification!.body);
    });




  }

  final AuthenticationRepository _authenticationRepository;
  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();
  final NotificationRepository _notificationRepository = NotificationRepository();
  late StreamSubscription<AppUser> _userSubscription;
  late StreamSubscription<FullUser> _userDetailsSubscription;
  late StreamSubscription<RemoteMessage> _firebaseOnMessageSubscription;
  late StreamSubscription<RemoteMessage> _firebaseOnMessageOpenedAppSubscription;



  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    print('User changed');
    print(event.user.isNotEmpty);
    print(event.user.displayName);
    print(event.user.email);
    print(event.user.id);

    if(event.user.isNotEmpty) {
      add(AppUserLoggedIn(event.user));
    }

    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }


  Future<void> _onAppUserLoggedIn(AppUserLoggedIn event, Emitter<AppState> emit) async {
    _notificationRepository.registerNotification(event.user.id);
    final FullUser currentDetails = await _firebaseUserRepository.getFullUserByUid(event.user.id);
    emit(state.copyWith(userDetails: currentDetails));
    _userDetailsSubscription = _firebaseUserRepository.fullUser(event.user.id).listen((FullUser fullUser) {
      add(UserDetailsChanged(fullUser));
    });
  }

  Future<void> _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) async {
    await _authenticationRepository.logOut();
    await _userDetailsSubscription.cancel();
  }

  void _onUserDetailsChanged(UserDetailsChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(userDetails: event.userDetails));
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    await _firebaseOnMessageSubscription.cancel();
    await _firebaseOnMessageOpenedAppSubscription.cancel();
    await _userDetailsSubscription.cancel();
    return super.close();
  }
}
