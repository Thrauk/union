import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/article/article.dart';
import 'package:union_app/src/repository/firestore/firebase_article_repository/firebase_article_reposiory.dart';

part 'project_posts_event.dart';

part 'project_posts_state.dart';

class ProjectPostsBloc extends Bloc<ProjectPostsEvent, ProjectPostsState> {
  ProjectPostsBloc(this._articleRepository) : super(const ProjectPostsState()) {
    on<GetArticles>(_getArticles);
  }

  final FirebaseArticleRepository _articleRepository;

  Future<FutureOr<void>> _getArticles(GetArticles event, Emitter<ProjectPostsState> emit) async {
    emit(state.copyWith(status: PageStatus.LOADING));
    final List<Article> articles = <Article>[];
    try {
      for (final String articleId in event.articlesId) {
        final Article? article = await _articleRepository.getArticleById(articleId);

        if (article != null) articles.add(article);
      }
      emit(state.copyWith(articles: articles, status: PageStatus.LOADED));
    } catch (e) {
      emit(state.copyWith(status: PageStatus.FAILED));
      if (kDebugMode) {
        print('_getArticles $e');
      }
    }
  }
}
