import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/models.dart';
import '../authentication.dart';
import 'failures/failures.dart';

class FirebaseAuthRepository implements AuthenticationRepository {
  FirebaseAuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  bool isWeb = kIsWeb;

  @override
  Future<void> logOut() async {
    try {
      // ignore: always_specify_types
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> logInWithEmailAndPassword({required String email, required String password}) async {
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
  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
        final firebase_auth.GoogleAuthProvider googleProvider = firebase_auth.GoogleAuthProvider();
        final firebase_auth.UserCredential userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
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
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebase_auth.User? firebaseUser) {
      final User user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  @override
  User get currentUser {
    final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
    final User user = firebaseUser == null ? User.empty : firebaseUser.toUser;
    return user;
}

}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
