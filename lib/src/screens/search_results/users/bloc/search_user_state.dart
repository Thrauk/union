part of 'search_user_bloc.dart';

class SearchUserState extends Equatable {
  const SearchUserState({
    this.userQueryResults = const <FullUser>[],
  });

  final List<FullUser> userQueryResults;

  @override
  List<Object?> get props => <Object>[userQueryResults];
}
