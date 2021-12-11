import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'article_item_widget_event.dart';
part 'article_item_widget_state.dart';

class ArticleItemWidgetBloc extends Bloc<ArticleItemWidgetEvent, ArticleItemWidgetState> {
  ArticleItemWidgetBloc() : super(ArticleItemWidgetInitial()) {
    on<ArticleItemWidgetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
