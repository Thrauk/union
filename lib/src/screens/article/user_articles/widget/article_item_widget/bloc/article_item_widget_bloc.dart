import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/repository/storage/firebase_article_repository/firebase_article_reposiory.dart';

part 'article_item_widget_event.dart';
part 'article_item_widget_state.dart';

class ArticleItemWidgetBloc extends Bloc<ArticleItemWidgetEvent, ArticleItemWidgetState> {
  ArticleItemWidgetBloc(this._articleRepository) : super(const ArticleItemWidgetState()) {
    on<GetDetails>(_getDetails);
    on<SetOwnerId>(_setOwnerId);
    on<OnTextPressed>(_modifyIsExpanded);
  }

  final FirebaseArticleRepository _articleRepository;

  Future<void> _getDetails(GetDetails event, Emitter<ArticleItemWidgetState> emit) async {
    final Map<String, String>? mapResult = await _articleRepository.getArticleUserDetails(event.ownerId);
    emit(state.copyWith(ownerDisplayName: mapResult!['owner_name'], ownerPhotoUrl: mapResult['owner_photo']));
  }

  void _setOwnerId(SetOwnerId event, Emitter<ArticleItemWidgetState> emit) {
    emit(state.copyWith(ownerId: event.ownerId));
    add(GetDetails(state.ownerId!));
  }

  Future<void> _modifyIsExpanded(OnTextPressed event, Emitter<ArticleItemWidgetState> emit) async {
    final bool isExpanded = state.isExpanded == true ? false : true;
    emit(state.copyWith(isExpanded: isExpanded));
  }


}
