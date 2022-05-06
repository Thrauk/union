import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_article_repository/firebase_article_reposiory.dart';
import 'package:union_app/src/screens/article/create_article/view/create_article_page.dart';
import 'package:union_app/src/screens/article/user_articles/widget/article_item_widget/view/article_item_widget.dart';
import 'package:union_app/src/screens/project/project_details/widgets/tabs/posts_tab/bloc/project_posts_bloc.dart';
import 'package:union_app/src/screens/widgets/exceptions/empty_page_widget.dart';
import 'package:union_app/src/theme.dart';

class PostsTabWidget extends StatelessWidget {
  const PostsTabWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    List<String> articlesId = <String>[];

    if (project.articlesId != null) {
      articlesId = project.articlesId!.map((dynamic e) => e.toString()).toList();
    }

    return BlocProvider<ProjectPostsBloc>(
      create: (BuildContext context) => ProjectPostsBloc(
        FirebaseArticleRepository(),
      )..add(
          GetArticles(articlesId),
        ),
      child: _PostsTabWidget(project: project),
    );
  }
}

class _PostsTabWidget extends StatelessWidget {
  const _PostsTabWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectPostsBloc, ProjectPostsState>(
      buildWhen: (ProjectPostsState previous, ProjectPostsState current) {
        return previous.articles != current.articles || previous.status != current.status;
      },
      builder: (BuildContext context, ProjectPostsState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  CreateArticlePage.route(projectId: project.id),
                );
              },
              foregroundColor: AppColors.backgroundLight,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.add),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Text('Posts', style: AppStyles.textStyleHeading1),
                ),
                if (state.status == PageStatus.LOADING)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  ))
                else if (state.articles.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ArticleItemWidget(article: state.articles[index]);
                      },
                    ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: EmptyPageWidget(message: 'No posts yet!'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
