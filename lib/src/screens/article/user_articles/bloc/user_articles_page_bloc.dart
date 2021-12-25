import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/article.dart';
import 'package:union_app/src/repository/storage/firebase_article_repository/firebase_article_reposiory.dart';

part 'user_articles_page_event.dart';
part 'user_articles_page_state.dart';

class UserArticlesPageBloc extends Bloc<UserArticlesPageEvent, UserArticlesPageState> {
  UserArticlesPageBloc(this._articleRepository) : super(const UserArticlesPageState()) {
    on<GetArticles>(_getArticles);
  }

  final FirebaseArticleRepository _articleRepository;

  Future<void> _getArticles(
      GetArticles event, Emitter<UserArticlesPageState> emit) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final List<Article> articles =
      await _articleRepository.getArticlesByUid(event.uid);
      print('articles $articles');
      emit(state.copyWith(articles: articles, status: PageStatus.success));
    } catch (e) {
      print('_getArticles $e');
      emit(state.copyWith(status: PageStatus.failed));
    }
  }
}
