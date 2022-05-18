import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/github/github_repository.dart';

part 'github_login_widget_event.dart';

part 'github_login_widget_state.dart';

class GithubLoginWidgetBloc extends Bloc<GithubLoginWidgetEvent, GithubLoginWidgetState> {
  GithubLoginWidgetBloc(this.firebaseAuthRepository) : super(const GithubLoginWidgetState()) {
    on<LoginPressed>(_onLoginPressed);
    on<Initialize>(_onInitialize);
    on<LoginSuccess>(_onLoginSuccess);
    on<LoginFailed>(_onLoginFailed);
  }

  late final StreamSubscription<String?> _subs;
  final GithubRepository _githubRepository = GithubRepository();
  final AuthenticationRepository firebaseAuthRepository;

  Future<void> _onInitialize(Initialize event, Emitter<GithubLoginWidgetState> emit) async {
    await _initDeepLinkListener();
  }

  Future<void> _onLoginPressed(LoginPressed event, Emitter<GithubLoginWidgetState> emit) async {
    await _githubRepository.queryOauthAuthorize();
  }

  void _onLoginSuccess(LoginSuccess event, Emitter<GithubLoginWidgetState> emit) {
    print('Login Success with github');
    emit(state.copyWith(loginSuccess: true));
  }

  void _onLoginFailed(LoginFailed event, Emitter<GithubLoginWidgetState> emit) {
    print('Login Failed with github');
  }

  Future<void> _initDeepLinkListener() async {
    _subs = linkStream.listen((String? link) async {
      await _checkDeepLink(link);
    }, cancelOnError: true);
  }

  Future<void> _checkDeepLink(String? link) async {
    if (link != null) {
      print(link);
      final String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      try {
        await firebaseAuthRepository.logInWithGithub(code: code);
        add(LoginSuccess());
      } catch (e) {
        print(e);
        add(LoginFailed());
      }
    }
  }

  @override
  Future<void> close() async {
    super.close();
    if (_subs != null) {
      _subs.cancel();
    }
  }
}
