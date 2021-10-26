import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/storage/firebase_storage/firebase_storage_repository.dart';

import 'failures/failures.dart';

class FirebaseAuthRepository implements AuthenticationRepository {
  FirebaseAuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    required FirebaseStorageRepository storageRepository,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _storageRepository = storageRepository;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseStorageRepository _storageRepository;
  bool isWeb = kIsWeb;

  @override
  Future<void> logOut() async {
    try {
      await Future.wait(
        <Future<void>>[
          _firebaseAuth.signOut(),
          _googleSignIn.signOut(),
        ],
      );
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredential;
    AppUser appUser;

    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // TODO(implement): save user details
      appUser = AppUser(
          id: userCredential.user!.uid,
          email: userCredential.user!.email,
          name: userCredential.user!.displayName);

      _storageRepository.userService.saveUserAuthDetails(appUser);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final firebase_auth.GoogleAuthProvider googleProvider =
            firebase_auth.GoogleAuthProvider();
        final firebase_auth.UserCredential userCredential =
            await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

/*
  void Test() async {
    String emailError;
    final FirebaseAuthFailure<String>? failure = await signUpWithEmailAndPassword(email: "mailu Meu", password: "1234");
    if(failure != null) {
      failure.map(serverFailure: (ServerFailure<String> error) { emailError = error.failedValue; }

      );
    }


    errorText: state.email.errorText ?? state.email.errorText : null,
  } */

  @override
  Stream<AppUser> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((firebase_auth.User? firebaseUser) {
      final AppUser user =
          firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
      return user;
    });
  }

  @override
  AppUser get currentUser {
    final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
    final AppUser user =
        firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
    return user;
  }
}

extension on firebase_auth.User {
  AppUser get toUser {
    return AppUser(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
