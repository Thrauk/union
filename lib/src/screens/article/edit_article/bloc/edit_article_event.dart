part of 'edit_article_bloc.dart';

@immutable
abstract class EditArticleEvent {}

class TagChanged extends EditArticleEvent {
  TagChanged(this.value);

  final String value;
}

class AddTagButtonPressed extends EditArticleEvent {
  AddTagButtonPressed(this.value);

  final String value;
}

class RemoveTagButtonPressed extends EditArticleEvent {
  RemoveTagButtonPressed(this.value);

  final String value;
}

class SaveButtonPressed extends EditArticleEvent {
  SaveButtonPressed();
}

class BodyChanged extends EditArticleEvent {
  BodyChanged(this.value);

  final String value;
}
