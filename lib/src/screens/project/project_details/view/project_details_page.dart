import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/view/add_open_role_page.dart';
import 'package:union_app/src/screens/project/edit_project/edit_project.dart';
import 'package:union_app/src/screens/project/project_details/bloc/project_details_bloc.dart';
import 'package:union_app/src/screens/project/project_details/widgets/tabs/barrel.dart';
import 'package:union_app/src/screens/widgets/dialogs/two_option_dialog.dart';
import 'package:union_app/src/theme.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({Key? key, required this.project}) : super(key: key);

  final Project project;

  static Route<void> route(Project project) {
    return MaterialPageRoute<void>(builder: (_) => ProjectDetailsPage(project: project));
  }

  @override
  Widget build(BuildContext context) {
    final String _loggedUserId = context.read<AppBloc>().state.user.id;
    final bool? isMember = project.membersUid?.contains(_loggedUserId);

    return BlocProvider<ProjectDetailsBloc>(
      create: (BuildContext context) => ProjectDetailsBloc(FirebaseProjectOpenRoleRepository(), FirebaseProjectRepository())
        ..add(GetOpenRoles(project.id))
        ..add(GetMembers(project.id)),
      child: Scaffold(
        body: DefaultTabController(
          length: isMember == true ? 3 : 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  indicatorColor: AppColors.primaryColor,
                  labelColor: AppColors.white09,
                  unselectedLabelColor: AppColors.white05,
                  labelStyle: AppStyles.textStyleBody,
                  tabs: <Widget>[
                    const Tab(
                      text: 'Details',
                    ),
                    const Tab(
                      text: 'Open Roles',
                    ),
                    if (isMember == true)
                      const Tab(
                        text: 'Posts',
                      ),
                  ]),
              actions: [
                if (_loggedUserId == project.ownerId)
                  Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: AppColors.backgroundLight1,
                      iconTheme: const IconThemeData(color: AppColors.white09),
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (String choice) => manageChoices(choice, context, project),
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
                  ),
              ],
              backgroundColor: AppColors.backgroundLight,
              title: Text(project.title ?? ''),
            ),
            body: TabBarView(
              children: [
                DetailsTabWidget(project: project),
                OpenRolesTabWidget(project: project),
                if (isMember == true) PostsTabWidget(project: project),
              ],
            ),
          ),
        ),
      ),
    );
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
        style: const TextStyle(color: AppColors.backgroundDark, fontWeight: FontWeight.w600),
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      backgroundColor: AppColors.primaryColor,
    );
  }
}

void manageChoices(String choice, BuildContext context, Project project) {
  switch (choice) {
    case Choices.delete:
      TwoOptionsDialog.showTwoOptionsDialog(
          context: context,
          optionOneFunction: () {
            FirebaseProjectRepository().deleteProject(project);
            Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (Route<dynamic> route) => false);
          },
          dialogSubtitle: 'Are you sure you want to delete this project?');
      break;
    case Choices.edit:
      Navigator.push(context, EditProjectPage.route(project));
      break;
    case Choices.add_open_role:
      Navigator.push(context, AddOpenRolePage.route(project.id));
  }
}

void showDeleteDialog(BuildContext context, Project project) {
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
                FirebaseProjectRepository().deleteProject(project);
                Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (Route<dynamic> route) => false);
              } catch (e) {
                print('showDeleteDialog $e');
              }
            },
            child: Text(
              'Yes',
              style: AppStyles.textStyleBody.merge(
                const TextStyle(color: AppColors.backgroundLight, fontWeight: FontWeight.w700),
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
        content: const Text('Are you sure you want to delete this project?', style: AppStyles.textStyleBody),
      ),
    ),
  );
}

class Choices {
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String add_open_role = 'Add an open role';

  static const List<String> choices = <String>[edit, delete, add_open_role];
}

bool isNotProjectOwner(String projectOwnerId, String userId) {
  return projectOwnerId != userId;
}
