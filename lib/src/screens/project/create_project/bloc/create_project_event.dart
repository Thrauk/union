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

class CreateButtonPressed extends CreateProjectEvent {
  CreateButtonPressed(this.ownerId, this.ownerDisplayName);

  final String ownerId;
  final String ownerDisplayName;
}

class CreateButtonPressedOrganization extends CreateProjectEvent {
  CreateButtonPressedOrganization(
    this.ownerId,
    this.ownerDisplayName,
    this.organizationId,
  );

  final String ownerId;
  final String ownerDisplayName;
  final String organizationId;
}

class RepositoryChosed extends CreateProjectEvent {
  RepositoryChosed(this.githubRepository);

  final GithubRepositoryItem githubRepository;
}

class RepositoryRemoved extends CreateProjectEvent {}

class IsGithubLinked extends CreateProjectEvent {
  IsGithubLinked(this.uid);

  final String uid;
}
