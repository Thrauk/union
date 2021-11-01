import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/models/form_inputs/name.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/authentication/auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final Email email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          // ignore: always_specify_types
          [
            email,
            state.name,
            state.password,
          ],
        ),
      ),
    );
  }

  void nameChanged(String value) {
    final Name name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate(
          // ignore: always_specify_types
          [
            state.email,
            name,
            state.password,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final Password password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          // ignore: always_specify_types
          [
            state.email,
            password,
          ],
        ),
      ),
    );
  }

  void showPasswordChanged() {
    emit(
      state.copyWith(showPassword: !state.showPassword),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
        email: state.email.value,
        name: state.name.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
