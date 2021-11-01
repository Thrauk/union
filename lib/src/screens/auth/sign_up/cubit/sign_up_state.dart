part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.showPassword = false,
  });

  final Email email;
  final Name name;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final bool showPassword;

  @override
  List<Object> get props =>
      <Object>[email, name, password, status, showPassword];

  SignUpState copyWith({
    Email? email,
    Name? name,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
    bool? showPassword,
  }) {
    return SignUpState(
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        showPassword: showPassword ?? this.showPassword);
  }
}
