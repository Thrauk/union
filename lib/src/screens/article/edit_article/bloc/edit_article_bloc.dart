import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/article/article.dart';
import 'package:union_app/src/models/form_inputs/article_body.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'edit_article_event.dart';

part 'edit_article_state.dart';

class EditArticleBloc extends Bloc<EditArticleEvent, EditArticleState> {
  EditArticleBloc(Article article, this._articleRepository) : super(EditArticleState(article: article)) {
    on<BodyChanged>(_bodyChanged);
    on<AddTagButtonPressed>(_addTagPressed);
    on<RemoveTagButtonPressed>(_removeTagPressed);
    on<SaveButtonPressed>(_saveButtonPressed);
    on<TagChanged>(_tagChanged);
  }

  final FirebaseArticleRepository _articleRepository;

  void _bodyChanged(BodyChanged event, Emitter<EditArticleState> emit) {
    final ArticleBody body = ArticleBody.dirty(event.value);
    emit(state.copyWith(article: state.article.copyWith(body: event.value), status: Formz.validate([body])));
  }

  void _addTagPressed(AddTagButtonPressed event, Emitter<EditArticleState> emit) {
    final TagName tag = TagName.dirty(event.value);
    if (!Formz.validate([tag]).isInvalid && !state.article.tags!.contains(tag.value)) {
      final List tagList = state.article.tags != null ? state.article.tags! + [tag.value] : [tag.value];
      emit(state.copyWith(article: state.article.copyWith(tags: tagList), tag: tag, status: Formz.validate([tag])));
    } else {
      emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
    }
  }

  void _tagChanged(TagChanged event, Emitter<EditArticleState> emit) {
    final TagName tag = TagName.dirty(event.value);
    emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
  }

  void _removeTagPressed(RemoveTagButtonPressed event, Emitter<EditArticleState> emit) {
    final List<dynamic> tagList = state.article.tags != null ? List.from(state.article.tags!.toList()) : List.from([]);
    tagList.removeWhere((element) => element == event.value);
    emit(state.copyWith(article: state.article.copyWith(tags: tagList), status: FormzStatus.valid));
  }

  void _saveButtonPressed(SaveButtonPressed event, Emitter<EditArticleState> emit) {
    if (state.status.isValid) {
      try {
        _articleRepository.updateArticle(state.article);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        print(state.status);
      } catch (_) {
        // TODO display on screen it's submission failure
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } else if (state.status.isPure) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
