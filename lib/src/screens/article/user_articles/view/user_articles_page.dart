import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/article/create_article/view/create_article_page.dart';
import 'package:union_app/src/screens/article/user_articles/bloc/user_articles_page_bloc.dart';
import 'package:union_app/src/screens/article/user_articles/widget/article_item_widget/view/article_item_widget.dart';
import 'package:union_app/src/screens/widgets/exceptions/empty_page_widget.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class UserArticlesPage extends StatelessWidget {
  const UserArticlesPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Articles'),
      body: BlocProvider<UserArticlesPageBloc>(
        child: _UserArticlesPage(uid: uid),
        create: (_) => UserArticlesPageBloc(FirebaseArticleRepository())
          ..add(GetArticles(uid)),
      ),
    );
  }
}

class _UserArticlesPage extends StatelessWidget {
  const _UserArticlesPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserArticlesPageBloc, UserArticlesPageState>(
      buildWhen:
          (UserArticlesPageState previous, UserArticlesPageState current) {
        return previous.articles != current.articles;
      },
      builder: (BuildContext context, UserArticlesPageState state) {
        return Column(
          children: <Widget>[
            const SizedBox(
              height: 6,
            ),
            if (state.status == PageStatus.loading ||
                state.status == PageStatus.initial)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            else
              Expanded(
                child: state.articles.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const EmptyPageWidget(message: "You haven't created any articles yet!"),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context, CreateArticlePage.route());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primaryColor,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                              side: const BorderSide(
                                width: 2.0,
                                color: AppColors.primaryColor,
                              ),
                              minimumSize: const Size(double.minPositive, 48),
                            ),
                            child: const Text(
                              'Create a new article',
                              style: AppStyles.buttonTextStyle,
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: false,
                        itemCount: state.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ArticleItemWidget(
                            article: state.articles[index],
                          );
                        },
                      ),
              ),
          ],
        );
      },
    );
  }
}
