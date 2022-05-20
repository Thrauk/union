import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/github/github_repository_item.dart';
import 'package:union_app/src/repository/github/github_repository.dart';

part 'user_repositories_event.dart';

part 'user_repositories_state.dart';

class UserRepositoriesBloc extends Bloc<UserRepositoriesEvent, UserRepositoriesState> {
  UserRepositoriesBloc() : super(const UserRepositoriesState()) {
    on<GetUserRepositories>(_getUserRepositories);
    on<RepositoryItemPressed>(_onRepositoryItemPressed);
  }

  final GithubRepository _githubRepository = GithubRepository();

  Future<FutureOr<void>> _getUserRepositories(GetUserRepositories event, Emitter<UserRepositoriesState> emit) async {
    try {
      final List<GithubRepositoryItem> repositories = await _githubRepository.getAllUsersRepositories(event.uid);
      emit(state.copyWith(repositories: repositories, status: PageStatus.SUCCESSFUL));
    } catch (_) {
      emit(state.copyWith(status: PageStatus.FAILED));
    }
  }

  FutureOr<void> _onRepositoryItemPressed(RepositoryItemPressed event, Emitter<UserRepositoriesState> emit) {}
}
