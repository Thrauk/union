part of 'multi_search_page_bloc.dart';

abstract class MultiSearchPageEvent extends Equatable {
  const MultiSearchPageEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class QueryTextChanged extends MultiSearchPageEvent {
  const QueryTextChanged({required this.queryText});

  final String queryText;

  @override
  List<Object> get props => <Object>[queryText];
}

class SearchTypeChanged extends MultiSearchPageEvent {
  const SearchTypeChanged({required this.searchType});

  final SearchType searchType;

  @override
  List<Object> get props => <Object>[searchType];
}

class SearchUserPressed extends MultiSearchPageEvent {}

class SearchProjectPressed extends MultiSearchPageEvent {}

class SearchPositionPressed extends MultiSearchPageEvent {}

class SearchArticlePressed extends MultiSearchPageEvent {}

class SearchPressed extends MultiSearchPageEvent {}


