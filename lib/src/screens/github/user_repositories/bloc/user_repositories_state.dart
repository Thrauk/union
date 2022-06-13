part of 'user_repositories_bloc.dart';

enum PageStatus { LOADING, SUCCESSFUL, FAILED }

class UserRepositoriesState extends Equatable {
  const UserRepositoriesState({this.repositories = const <GithubRepositoryItem>[], this.status = PageStatus.LOADING});

  final List<GithubRepositoryItem> repositories;
  final PageStatus status;

  UserRepositoriesState copyWith({List<GithubRepositoryItem>? repositories, PageStatus? status}) {
    return UserRepositoriesState(repositories: repositories ?? this.repositories, status: status ?? this.status);
  }

  @override
  List<Object?> get props => <Object?>[repositories, status];
}
