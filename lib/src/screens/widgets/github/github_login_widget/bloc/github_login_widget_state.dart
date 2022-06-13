part of 'github_login_widget_bloc.dart';

class GithubLoginWidgetState extends Equatable {
  const GithubLoginWidgetState({
    this.loginSuccess = false,
  });

  final bool loginSuccess;

  GithubLoginWidgetState copyWith({bool? loginSuccess}) {
    return GithubLoginWidgetState(
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }

  @override
  List<Object> get props => <Object>[loginSuccess];
}
