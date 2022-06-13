import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/article/create_article/bloc/bloc.dart';
import 'package:union_app/src/screens/article/create_article/widgets/widgets.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';

class CreateArticlePage extends StatelessWidget {
  const CreateArticlePage({Key? key, this.projectId = ''}) : super(key: key);

  static Route<void> route({String projectId = ''}) {
    return MaterialPageRoute<void>(builder: (_) => CreateArticlePage(projectId: projectId));
  }

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateArticleBloc>(
      create: (BuildContext context) => CreateArticleBloc(FirebaseArticleRepository()),
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'Create article'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Expanded(
                child: BodyInputWidget(),
              ),
              const TagsContainer(),
              PublishButtonWidget(projectId: projectId),
            ],
          ),
        ),
      ),
    );
  }
}
