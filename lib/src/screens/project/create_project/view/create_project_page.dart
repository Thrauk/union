import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreateProjectPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateProjectBloc>(
      create: (BuildContext context) =>
          CreateProjectBloc(FirebaseProjectRepository()),
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'Create project'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                SizedBox(height: 16),
                GithubButtonWidget(),
                SizedBox(height: 24),
                TitleInputWidget(),
                SizedBox(height: 8),
                ShortDescriptionInputWidget(),
                SizedBox(height: 8),
                DetailsInputWidget(),
                SizedBox(height: 8),
                TagsContainer(),
                SizedBox(height: 16),
                CreateButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
