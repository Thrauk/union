import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:union_app/src/app_data/app_data.dart';
import 'package:union_app/src/models/github/github_login_request.dart';
import 'package:union_app/src/models/github/github_login_response.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

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
      await FirebaseMessaging.instance.deleteToken();
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
  Future<void> signUpWithEmailAndPassword({required String email, required String password, required String name}) async {
    UserCredential userCredential;
    AppUser appUser;

    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseAuth.currentUser!.updateDisplayName(name);

      appUser = AppUser(id: userCredential.user!.uid, email: userCredential.user!.email, displayName: name);

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
      final firebase_auth.UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      final AppUser appUser = AppUser(
        id: userCredential.user!.uid,
        email: userCredential.user!.email,
        displayName: userCredential.user!.displayName,
        photo: userCredential.user!.photoURL,
      );

      _storageRepository.userService.saveUserAuthDetails(appUser);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      print(_);
      print('here');
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<void> logInWithGithub({required String code}) async {
    final http.Response response = await http.post(
      Uri.parse('https://github.com/login/oauth/access_token'),
      headers: <String, String>{'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: jsonEncode(GithubLoginRequest(
        clientId: AppData.GithubClientId,
        clientSecret: AppData.GithubClientSecret,
        code: code,
      ).toJson(),)
    );
    print('param code $code');

    final GithubLoginResponse loginResponse = GithubLoginResponse.fromJson(json.decode(response.body) as Map<String, dynamic>);

    print('login response code  ${loginResponse.accessToken}');

    final AuthCredential credential = firebase_auth.GithubAuthProvider.credential(loginResponse.accessToken);

    final firebase_auth.UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);


    print(userCredential.user!.email);
    print(userCredential);

    final http.Response emailResponse = await http.get(
        Uri.parse('https://api.github.com/user/emails'),
        headers: <String, String>{'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization' : 'token ${loginResponse.accessToken}'},
    );

    print(jsonDecode(emailResponse.body));

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
    return _firebaseAuth.authStateChanges().map((firebase_auth.User? firebaseUser) {
      final AppUser user = firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
      return user;
    });
  }

  @override
  AppUser get currentUser {
    final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
    final AppUser user = firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
    return user;
  }
}

extension on firebase_auth.User {
  AppUser get toUser {
    return AppUser(id: uid, email: email, displayName: displayName, photo: photoURL);
  }
}
