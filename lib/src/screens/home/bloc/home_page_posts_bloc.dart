import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/article.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_article_repository/firebase_article_reposiory.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';

part 'home_page_posts_event.dart';

part 'home_page_posts_state.dart';

class HomePagePostsBloc extends Bloc<HomePagePostsEvent, HomePagePostsState> {
  HomePagePostsBloc(this._projectRepository, this._articleRepository) : super(const HomePagePostsState()) {
    on<GetArticles>(_getArticles);
    on<GetAll>(_getAll);
    on<GetProjects>(_getProjects);
  }

  final FirebaseProjectRepository _projectRepository;
  final FirebaseArticleRepository _articleRepository;

  Future<FutureOr<void>> _getArticles(GetArticles event, Emitter<HomePagePostsState> emit) async {
    try {
      final List<Article> articles = await _articleRepository.getArticles(20);
        emit(state.copyWith(postType: PostType.ARTICLE, posts: articles));
    } catch (e) {
      print('_getArticles $e');
    }
  }

  Future<FutureOr<void>> _getProjects(GetProjects event, Emitter<HomePagePostsState> emit) async {
    try {
      final List<Project> projects = await _projectRepository.getProjects(20);
      projects.removeWhere((Project project) => project.organizationId != '');
      emit(state.copyWith(postType: PostType.PROJECT, posts: projects));
    } catch (e) {
      print('_getProjects $e');
    }
  }

  Future<FutureOr<void>> _getAll(GetAll event, Emitter<HomePagePostsState> emit) async {
    try {
    } catch (e) {
      print('_geProjects $e');
    }
  }
}
