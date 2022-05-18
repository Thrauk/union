import 'package:union_app/src/models/models.dart';

abstract class AuthenticationRepository {
  Stream<AppUser> get user;

  AppUser get currentUser;

  Future<void> logInWithGoogle();

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> logInWithGithub({required String code});

  Future<void> logOut();
}
