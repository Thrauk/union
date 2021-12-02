// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/screens/project/user_projects/bloc/user_projects_page_bloc.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/view/project_item_widget.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class UserProjectsPage extends StatelessWidget {
  const UserProjectsPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Projects'),
      body: BlocProvider<UserProjectsPageBloc>(
        child: _UserProjectsPage(uid: uid),
        create: (_) => UserProjectsPageBloc(FirebaseProjectRepository())
          ..add(GetProjects(uid)),
      ),
    );
  }
}

class _UserProjectsPage extends StatelessWidget {
  const _UserProjectsPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProjectsPageBloc, UserProjectsPageState>(
      buildWhen:
          (UserProjectsPageState previous, UserProjectsPageState current) {
        return previous.projects != current.projects;
      },
      builder: (BuildContext context, UserProjectsPageState state) {
        return Column(
          children: <Widget>[
            const SizedBox(
              height: 6,
            ),
            state.status == PageStatus.loading || state.status == PageStatus.initial
                ? const Center(child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
                : Expanded(
                    child: state.projects.isEmpty
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 34),
                                child: Image(
                                  image: AssetImage('assets/icons/empty.png'),
                                ),
                              ),
                              SizedBox(height: 32),
                              Text(
                                "You haven\'t created any projects yet!",
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: AppColors.white07,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: false,
                            itemCount: state.projects.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProjectItemWidget(
                                project: state.projects[index],
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