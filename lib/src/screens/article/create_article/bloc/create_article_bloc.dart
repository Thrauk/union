import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/models/form_inputs/article_body.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'create_article_event.dart';

part 'create_article_state.dart';

class CreateArticleBloc extends Bloc<CreateArticleEvent, CreateArticleState> {
  CreateArticleBloc(this._articleRepository) : super(const CreateArticleState()) {
    on<BodyChanged>(_bodyChanged);
    on<AddTagButtonPressed>(_addTagPressed);
    on<RemoveTagButtonPressed>(_removeTagPressed);
    on<PublishButtonPressed>(_publishButtonPressed);
  }

  final FirebaseArticleRepository _articleRepository;

  void _bodyChanged(BodyChanged event, Emitter<CreateArticleState> emit) {
    final ArticleBody body = ArticleBody.dirty(event.value);
    emit(state.copyWith(body: body, status: Formz.validate([body])));
  }

  void _addTagPressed(AddTagButtonPressed event, Emitter<CreateArticleState> emit) {
    final TagName tag = TagName.dirty(event.value);
    if (!Formz.validate([tag]).isInvalid && !state.tagItems.contains(tag)) {
      final List<TagName> tagList = state.tagItems + [tag];
      emit(state.copyWith(tagItems: tagList, tag: tag, status: Formz.validate([tag])));
    } else {
      emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
    }
  }

  void _removeTagPressed(RemoveTagButtonPressed event, Emitter<CreateArticleState> emit) {
    final List<TagName> tagList = List.from(state.tagItems);
    tagList.removeWhere((TagName element) => element.value == event.value);
    emit(state.copyWith(tagItems: tagList));
  }

  void _publishButtonPressed(PublishButtonPressed event, Emitter<CreateArticleState> emit) {
    if (state.status.isValid) {
      final bool isPublic = event.projectId.isEmpty;
      final List<String> tags = state.tagItems.map((TagName e) => e.value).toList();
      try {
        final Article article = Article(
          body: state.body.value,
          tags: tags,
          ownerId: event.ownerId,
          date: DateTime.now().microsecondsSinceEpoch,
          isPublic: isPublic,
        );
        _articleRepository.createArticle(article, projectId: event.projectId);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
