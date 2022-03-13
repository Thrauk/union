import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/article/user_articles/widget/article_item_widget/view/article_item_widget.dart';
import 'package:union_app/src/screens/home/bloc/home_page_posts_bloc.dart';
import 'package:union_app/src/screens/home/widgets/choose_posts_type_widget.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/view/project_item_widget.dart';
import 'package:union_app/src/screens/widgets/app_bar/app_bar_with_search_bar.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePagePostsBloc>(
      create: (BuildContext context) =>
          HomePagePostsBloc(FirebaseProjectRepository(), FirebaseArticleRepository())..add(GetProjects()),
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePagePostsBloc, HomePagePostsState>(
      buildWhen: (HomePagePostsState previous, HomePagePostsState current) {
        return previous.postType != current.postType || previous.posts != current.posts;
      },
      builder: (BuildContext context, HomePagePostsState state) {
        return Scaffold(
          drawer: const AppDrawer(),
          bottomNavigationBar: const CustomNavBar(),
          appBar: const AppBarWithSearchBar(),
          body: Column(
            children: <Widget>[
              const ChoosePostTypeWidget(),
              Expanded(
                child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(state.postType);
                    return state.postType == PostType.PROJECT
                        ? ProjectItemWidget(project: state.posts[index] as Project)
                        : ArticleItemWidget(article: state.posts[index] as Article);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
