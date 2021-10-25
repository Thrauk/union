import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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
            state.password,
            state.confirmedPassword,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final Password password = Password.dirty(value);
    final ConfirmedPassword confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate(
          // ignore: always_specify_types
          [
            state.email,
            password,
            confirmedPassword,
          ],
        ),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final ConfirmedPassword confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate(
          // ignore: always_specify_types
          [
            state.email,
            state.password,
            confirmedPassword,
          ],
        ),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated)
      return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
        email: state.email.value,
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
}
