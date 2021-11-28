part of 'create_project_bloc.dart';

@immutable
abstract class CreateProjectEvent {}

class TitleChanged extends CreateProjectEvent {
  TitleChanged(this.value);

  final String value;
}

class DetailsChanged extends CreateProjectEvent {
  DetailsChanged(this.value);

  final String value;
}

class ShortDescriptionChanged extends CreateProjectEvent {
  ShortDescriptionChanged(this.value);

  final String value;
}

class TagChanged extends CreateProjectEvent {
  TagChanged(this.value);

  final String value;
}

class AddTagButtonPressed extends CreateProjectEvent {
  AddTagButtonPressed(this.value);

  final String value;
}

class RemoveTagButtonPressed extends CreateProjectEvent {
  RemoveTagButtonPressed(this.value);

  final String value;
}

