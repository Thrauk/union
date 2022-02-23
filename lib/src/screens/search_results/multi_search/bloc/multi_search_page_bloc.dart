import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/repository/organization/firebase_organization_repository.dart';

part 'multi_search_page_event.dart';
part 'multi_search_page_state.dart';

class MultiSearchPageBloc extends Bloc<MultiSearchPageEvent, MultiSearchPageState> {
  MultiSearchPageBloc() : super(const MultiSearchPageState()) {
    on<QueryTextChanged>(_onQueryTextChanged);
    on<SearchTypeChanged>(_onSearchTypeChanged);
    on<SearchUserPressed>(_onSearchUserPressed);
    on<SearchProjectPressed>(_onSearchProjectPressed);
    on<SearchArticlePressed>(_onSearchArticlePressed);
    on<SearchPressed>(_onSearchPressed);
    on<SearchOrganizationPressed>(_onSearchOrganizationPressed);
  }

  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();
  final FirebaseProjectRepository _firebaseProjectRepository = FirebaseProjectRepository();
  final FirebaseArticleRepository _firebaseArticleRepository = FirebaseArticleRepository();
  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();

  void _onQueryTextChanged(QueryTextChanged event, Emitter<MultiSearchPageState> emit) {
    emit(state.copyWith(searchText: event.queryText));
  }

  void _onSearchTypeChanged(SearchTypeChanged event, Emitter<MultiSearchPageState> emit) {
    emit(state.copyWith(searchType: event.searchType, resultList: <dynamic>[]));
  }

  Future<void> _onSearchPressed(SearchPressed event, Emitter<MultiSearchPageState> emit) async {
    if (state.searchText != '') {
      switch (state.searchType) {
        case SearchType.user:
          add(SearchUserPressed());
          break;
        case SearchType.project:
          add(SearchProjectPressed());
          break;
        case SearchType.article:
          add(SearchArticlePressed());
          break;
        case SearchType.organization:
          add(SearchOrganizationPressed());
          break;
        case SearchType.position:
          break;
      }
    }
  }

  Future<void> _onSearchUserPressed(SearchUserPressed event, Emitter<MultiSearchPageState> emit) async {
    final List<FullUser> users = await _firebaseUserRepository.getAllUsers();
    final List<FullUser> filteredUsers = users
        .where((FullUser user) =>
            user.displayName!.contains(state.searchText) ||
            (user.jobTitle ?? '').contains(state.searchText) ||
            (user.location ?? '').contains(state.searchText))
        .toList();
    emit(state.copyWith(resultList: filteredUsers));
  }

  Future<void> _onSearchProjectPressed(SearchProjectPressed event, Emitter<MultiSearchPageState> emit) async {
    final List<Project> projects = await _firebaseProjectRepository.getAllProjects();
    final List<Project> filteredProjects = projects
        .where((Project project) =>
            (project.title ?? '').contains(state.searchText) ||
            project.details.contains(state.searchText) ||
            (project.tags ?? <String>[]).contains(state.searchText))
        .toList();
    emit(state.copyWith(resultList: filteredProjects));
  }

  Future<void> _onSearchArticlePressed(SearchArticlePressed event, Emitter<MultiSearchPageState> emit) async {
    final List<Article> articles = await _firebaseArticleRepository.getAllArticles();
    final List<Article> filteredArticles =
        articles.where((Article article) => article.body!.contains(state.searchText)).toList();
    emit(state.copyWith(resultList: filteredArticles));
  }

  Future<void> _onSearchOrganizationPressed(SearchOrganizationPressed event, Emitter<MultiSearchPageState> emit) async {
    final List<Organization> organizations = await _firebaseOrganizationRepository.getAllOrganizations();
    final List<Organization> filteredOrganizations = organizations
        .where((Organization organization) =>
            organization.location.contains(state.searchText) ||
            organization.category.contains(state.searchText) ||
            organization.name.contains(state.searchText))
        .toList();
    emit(state.copyWith(resultList: filteredOrganizations));
  }
}
