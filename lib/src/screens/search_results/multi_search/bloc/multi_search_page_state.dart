part of 'multi_search_page_bloc.dart';

enum SearchType { user, project, position, article, organization }

class MultiSearchPageState extends Equatable {
  const MultiSearchPageState({
    this.searchType = SearchType.user,
    this.searchText = '',
    this.resultList = const <dynamic>[],
  });

  final SearchType searchType;
  final String searchText;
  final List<dynamic> resultList;

  MultiSearchPageState copyWith({
    SearchType? searchType,
    String? searchText,
    List<dynamic>? resultList,
  }) {
    return MultiSearchPageState(
      searchType: searchType ?? this.searchType,
      searchText: searchText ?? this.searchText,
      resultList: resultList ?? this.resultList,
    );
  }

  @override
  List<Object?> get props => <Object?>[searchType, searchText, resultList];
}
