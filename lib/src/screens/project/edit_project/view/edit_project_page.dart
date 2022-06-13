import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/main/view/main_screen.dart';
import 'package:union_app/src/screens/project/edit_project/edit_project.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/theme.dart';

class EditProjectPage extends StatelessWidget {
  const EditProjectPage({Key? key, required this.project}) : super(key: key);

  final Project project;

  static Route<void> route(Project project) {
    return MaterialPageRoute<void>(builder: (_) =>  EditProjectPage(project: project));
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProjectBloc>(
      create: (BuildContext context) =>
          EditProjectBloc(project, FirebaseProjectRepository()),
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'Edit project'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                const TitleInputWidget(),
                const SizedBox(height: 16),
                const ShortDescriptionInputWidget(),
                const SizedBox(height: 16),
                const DetailsInputWidget(),
                const SizedBox(height: 16),
                const TagsContainer(),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Expanded(flex: 1, child: SaveButtonWidget()),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MainPage.route()),
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
      ),
    );
  }
}
