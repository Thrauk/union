part of 'articles_list_bloc.dart';

abstract class ArticlesListEvent extends Equatable {
  const ArticlesListEvent();
  @override
  List<Object?> get props => <Object?>[];
}

class Initialize extends ArticlesListEvent {}
