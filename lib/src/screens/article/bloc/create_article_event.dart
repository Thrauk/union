part of 'create_article_bloc.dart';

abstract class CreateArticleEvent {
  const CreateArticleEvent();
}

class BodyChanged extends CreateArticleEvent {
  BodyChanged(this.value);

  final String value;
}

class TagChanged extends CreateArticleEvent {
  TagChanged(this.value);

  final String value;
}

class AddTagButtonPressed extends CreateArticleEvent {
  AddTagButtonPressed(this.value);

  final String value;
}

class RemoveTagButtonPressed extends CreateArticleEvent {
  RemoveTagButtonPressed(this.value);

  final String value;
}

class PublishButtonPressed extends CreateArticleEvent {
  PublishButtonPressed(this.ownerId);

  final String ownerId;
}
