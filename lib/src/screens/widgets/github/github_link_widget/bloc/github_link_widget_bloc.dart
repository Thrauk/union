import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_links/uni_links.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/github/github_repository.dart';

part 'github_link_widget_event.dart';
part 'github_link_widget_state.dart';

class GithubLinkWidgetBloc extends Bloc<GithubLinkWidgetEvent, GithubLinkWidgetState> {
  GithubLinkWidgetBloc(this.firebaseAuthRepository) : super(const GithubLinkWidgetState()) {
    on<LinkPressed>(_onLinkPressed);
    on<Initialize>(_onInitialize);
    on<LinkSuccess>(_onLinkSuccess);
    on<LinkFailed>(_onLinkFailed);
  }

  late final StreamSubscription<String?> _subs;
  final GithubRepository _githubRepository = GithubRepository();
  final AuthenticationRepository firebaseAuthRepository;

  Future<void> _onInitialize(Initialize event, Emitter<GithubLinkWidgetState> emit) async {
    await _initDeepLinkListener();
  }

  Future<void> _onLinkPressed(LinkPressed event, Emitter<GithubLinkWidgetState> emit) async {
    await _githubRepository.queryOauthAuthorize();
  }

  void _onLinkSuccess(LinkSuccess event, Emitter<GithubLinkWidgetState> emit) {
    print('Link Success with github');
    emit(state.copyWith(linkSuccess: true));
  }

  void _onLinkFailed(LinkFailed event, Emitter<GithubLinkWidgetState> emit) {
    print('Link Failed with github');
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
        await firebaseAuthRepository.linkWithGithub(code: code);
        add(LinkSuccess());
      } catch (e) {
        print(e);
        add(LinkFailed());
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
