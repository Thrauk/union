part of 'user_articles_page_bloc.dart';

abstract class UserArticlesPageEvent {
  const UserArticlesPageEvent();
}

class GetArticles extends UserArticlesPageEvent {
  GetArticles(this.uid);

  final String uid;
}
