part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.hidePassword = true,
  });

  final Email email;
  final Name name;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final bool hidePassword;

  @override
  List<Object> get props =>
      <Object>[email, name, password, status, hidePassword];

  SignUpState copyWith({
    Email? email,
    Name? name,
    Password? password,
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
        hidePassword: showPassword ?? this.hidePassword);
  }
}
