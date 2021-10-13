
import 'package:union_app/src/models/models.dart';

abstract class AuthenticationRepository {
  Stream<User> get user;

  User get currentUser;

  Future<void> logInWithGoogle();

  Future<void> signUpWithEmailAndPassword({required String email, required String password});

  Future<void> logInWithEmailAndPassword({required String email, required String password});

  Future<void> logOut();

}
