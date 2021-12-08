part of 'edit_project_bloc.dart';


@immutable
abstract class EditProjectEvent {}

class TitleChanged extends EditProjectEvent {
  TitleChanged(this.value);

  final String value;
}

class DetailsChanged extends EditProjectEvent {
  DetailsChanged(this.value);

  final String value;
}

class ShortDescriptionChanged extends EditProjectEvent {
  ShortDescriptionChanged(this.value);

  final String value;
}

class TagChanged extends EditProjectEvent {
  TagChanged(this.value);

  final String value;
}

class AddTagButtonPressed extends EditProjectEvent {
  AddTagButtonPressed(this.value);

  final String value;
}

class RemoveTagButtonPressed extends EditProjectEvent {
  RemoveTagButtonPressed(this.value);

  final String value;
}

class SaveButtonPressed extends EditProjectEvent {
  SaveButtonPressed();
}
