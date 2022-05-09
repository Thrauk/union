// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/screens/project/user_projects/bloc/user_projects_bloc.dart';
import 'package:union_app/src/screens/project/user_projects/widgets/choose_project_type_buttons.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/view/project_item_widget.dart';
import 'package:union_app/src/screens/widgets/exceptions/empty_page_widget.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class UserProjectsPage extends StatelessWidget {
  const UserProjectsPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<UserProjectsBloc>(
        child: _UserProjectsPage(uid: uid),
        create: (_) => UserProjectsBloc(FirebaseProjectRepository())..add(GetProjects(uid, ProjectType.OWNED)),
      ),
    );
  }
}

class _UserProjectsPage extends StatelessWidget {
  const _UserProjectsPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProjectsBloc, UserProjectsState>(
      buildWhen: (UserProjectsState previous, UserProjectsState current) {
        return previous.projects != current.projects ||
            previous.projectType != current.projectType ||
            previous.status != current.status;
      },
      builder: (BuildContext context, UserProjectsState state) {
        return Column(
          children: <Widget>[
            ChooseProjectTypeWidget(
              projectType: state.projectType,
              myProjectsPressed: () => context.read<UserProjectsBloc>().add(ProjectTypeChanged(ProjectType.OWNED, uid)),
              joinedProjectsPressed: () => context.read<UserProjectsBloc>().add(ProjectTypeChanged(ProjectType.JOINED, uid)),
            ),
            state.status == PageStatus.loading || state.status == PageStatus.initial
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ))
                : Expanded(
                    child: state.projects.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const EmptyPageWidget(message: "You haven't created any projects yet!"),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, CreateProjectPage.route());
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
                                  'Create a new project',
                                  style: AppStyles.buttonTextStyle,
                                ),
                              )
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
