import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({Key? key, this.organizationId = ''}) : super(key: key);

  static Route<void> route({String? organizationId}) {
    return MaterialPageRoute<void>(
        builder: (_) => CreateProjectPage(
              organizationId: organizationId ?? '',
            ));
  }

  final String organizationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateProjectBloc>(
      create: (BuildContext context) => CreateProjectBloc(FirebaseProjectRepository()),
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'Create project'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const GithubButtonWidget(),
                const SizedBox(height: 16),
                const TitleInputWidget(),
                const SizedBox(height: 16),
                const ShortDescriptionInputWidget(),
                const SizedBox(height: 16),
                const DetailsInputWidget(),
                const SizedBox(height: 16),
                const TagsContainer(),
                const SizedBox(height: 16),
                CreateButtonWidget(
                  organizationId: organizationId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
