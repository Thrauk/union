part of 'github_login_widget_bloc.dart';

class GithubLoginWidgetEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class Initialize extends GithubLoginWidgetEvent {}

class LoginPressed extends GithubLoginWidgetEvent {}

class LoginSuccess extends GithubLoginWidgetEvent {}

class LoginFailed extends GithubLoginWidgetEvent {}

