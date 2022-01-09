import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/notification/notification_repository.dart';
import 'package:union_app/src/repository/storage/firebase_user/firebase_user.dart';

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
  late final StreamSubscription<AppUser> _userSubscription;
  late final StreamSubscription<FullUser> _userDetailsSubscription;
  late final StreamSubscription<RemoteMessage> _firebaseOnMessageSubscription;
  late final StreamSubscription<RemoteMessage> _firebaseOnMessageOpenedAppSubscription;



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
      emit(state.copyWith(userDetails: fullUser));
    });
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    _authenticationRepository.logOut();
    _userDetailsSubscription.cancel();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _firebaseOnMessageSubscription.cancel();
    _firebaseOnMessageOpenedAppSubscription.cancel();
    _userDetailsSubscription.cancel();
    return super.close();
  }
}
