import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/article/edit_article/bloc/edit_article_bloc.dart';
import 'package:union_app/src/screens/article/edit_article/widgets/buttons/save_button_widget.dart';
import 'package:union_app/src/screens/article/edit_article/widgets/containers/tags_container.dart';
import 'package:union_app/src/screens/article/edit_article/widgets/form_fields/body_input_widget.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class EditArticlePage extends StatelessWidget {
  const EditArticlePage({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EditArticleBloc(
        article,
        FirebaseArticleRepository(),
      ),
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'Edit Article'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Expanded(child: BodyInputWidget()),
              const TagsContainer(),
              Row(
                children: <Widget>[
                  const Expanded(flex: 1, child: SaveButtonWidget()),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(HomePage.route()),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: AppStyles.textStyleHeading1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
