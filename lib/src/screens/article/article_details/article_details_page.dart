import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_article_repository/firebase_article_reposiory.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/theme.dart';

class ArticleDetailsPage extends StatelessWidget {
  ArticleDetailsPage({Key? key, required this.article}) : super(key: key);

  Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              cardColor: AppColors.backgroundLight1,
              iconTheme: const IconThemeData(color: AppColors.white09),
            ),
            child: PopupMenuButton<String>(
              onSelected: (String choice) =>
                  manageChoices(choice, context, article),
              itemBuilder: (BuildContext context) {
                return Choices.choices.map(
                  (String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: const TextStyle(color: AppColors.white09),
                      ),
                    );
                  },
                ).toList();
              },
            ),
          )
        ],
        backgroundColor: AppColors.backgroundLight,
        title: const Text('Article'),
      ),
      body: _ArticleDetailsPage(article: article),
    );
  }
}

class _ArticleDetailsPage extends StatelessWidget {
  const _ArticleDetailsPage({Key? key, required this.article})
      : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(article.body ?? '', style: AppStyles.textStyleBody),
            if (article.tags!.isNotEmpty)
              Wrap(
                spacing: 4,
                children: article.tags!
                    .map(
                      (dynamic tag) => TagWidget(label: tag as String),
                )
                    .toList()
                    .cast<Widget>(),
              )
            else
              const Text(''),
          ],
        ),
      ),
    );
  }
}

void manageChoices(String choice, BuildContext context, Article article) {
  switch (choice) {
    case Choices.delete:
      showDeleteDialog(context, article);
      break;
    case Choices.edit:
      break;
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
            color: AppColors.backgroundDark, fontWeight: FontWeight.w600),
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      backgroundColor: AppColors.primaryColor,
    );
  }
}


void showDeleteDialog(BuildContext context, Article article) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Center(
      child: AlertDialog(
        elevation: 20,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.primaryColor,
            ),
            onPressed: () {
              try {
                FirebaseArticleRepository().deleteArticle(article);
                Navigator.of(context).pushAndRemoveUntil(
                    HomePage.route(), (Route<dynamic> route) => false);
              } catch (e) {
                print('showDeleteDialog $e');
              }
            },
            child: Text(
              'Yes',
              style: AppStyles.textStyleBody.merge(
                const TextStyle(
                    color: AppColors.backgroundLight,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              'No',
              style: AppStyles.textStyleBody.merge(
                const TextStyle(color: AppColors.redLight),
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.backgroundLight,
        title: const Text('Hold on!', style: AppStyles.textStyleHeading1),
        content: const Text('Are you sure you want to delete this article?',
            style: AppStyles.textStyleBody),
      ),
    ),
  );
}

class Choices {
  static const String edit = 'Edit';
  static const String delete = 'Delete';

  static const List<String> choices = <String>[edit, delete];
}
