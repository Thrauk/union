import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/article/article.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'articles_list_event.dart';

part 'articles_list_state.dart';

class ArticlesListBloc extends Bloc<ArticlesListEvent, ArticlesListState> {
  ArticlesListBloc({required String uid})
      : _uid = uid,
        super(const ArticlesListState()) {
    on<Initialize>(_onInitialize);
  }

  final String _uid;
  final FirebaseArticleRepository _firebaseArticleRepository = FirebaseArticleRepository();

  Future<void> _onInitialize(Initialize event, Emitter<ArticlesListState> emit) async {
    final List<Article> articleList = await _firebaseArticleRepository.getQueryArticlesByUid(_uid);
    emit(
      state.copyWith(articleList: articleList, loaded: true),
    );
  }
}
