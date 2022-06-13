part of 'user_repositories_bloc.dart';

@immutable
abstract class UserRepositoriesEvent {}

class GetUserRepositories extends UserRepositoriesEvent {
  GetUserRepositories(this.uid);

  final String uid;
}

class RepositoryItemPressed extends UserRepositoriesEvent {
  RepositoryItemPressed(this.repositoryName);

  final String repositoryName;
}
