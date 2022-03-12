import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/article/create_article/view/create_article_page.dart';
import 'package:union_app/src/screens/article/user_articles/widget/article_item_widget/view/article_item_widget.dart';
import 'package:union_app/src/screens/project/project_details/bloc/project_details_bloc.dart';
import 'package:union_app/src/screens/project/project_details/widgets/create_post_widget.dart';
import 'package:union_app/src/theme.dart';

class PostsTabWidget extends StatelessWidget {
  const PostsTabWidget({Key? key, required this.projectId}) : super(key: key);

  final String projectId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      buildWhen: (ProjectDetailsState previous, ProjectDetailsState current) {
        return previous.articles != current.articles;
      },
      builder: (BuildContext context, ProjectDetailsState state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CreateArticlePage.route(projectId: projectId));
                },
                child: const CreatePostWidget(),
              ),
              const SizedBox(height: 16),
              const Text('Posts', style: AppStyles.textStyleHeading1),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: state.articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ArticleItemWidget(article: state.articles[index]);
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
