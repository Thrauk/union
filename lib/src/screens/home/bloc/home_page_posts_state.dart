part of 'home_page_posts_bloc.dart';

enum PostType { ARTICLE, PROJECT, ALL }

class HomePagePostsState extends Equatable {
  const HomePagePostsState({this.postType = PostType.ARTICLE, this.posts = const <dynamic>[]});

  final PostType postType;
  final List<dynamic> posts;

  @override
  List<Object?> get props => [posts, postType];

  HomePagePostsState copyWith({PostType? postType, List<dynamic>? posts}) {
    return HomePagePostsState(posts: posts ?? this.posts, postType: postType ?? this.postType);
  }
}
