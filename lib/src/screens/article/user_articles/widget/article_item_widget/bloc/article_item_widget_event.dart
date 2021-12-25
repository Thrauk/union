part of 'article_item_widget_bloc.dart';

@immutable
abstract class ArticleItemWidgetEvent {}

class GetDetails extends ArticleItemWidgetEvent {
  GetDetails(this.ownerId);

  final String ownerId;
}
class SetOwnerId extends ArticleItemWidgetEvent {
  SetOwnerId(this.ownerId);

  final String ownerId;
}

class OnTextPressed extends ArticleItemWidgetEvent {
  OnTextPressed();
}