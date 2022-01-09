import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_open_role_repository.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/view/add_open_role_page.dart';
import 'package:union_app/src/screens/project/edit_project/edit_project.dart';
import 'package:union_app/src/screens/project/project_details/bloc/project_details_bloc.dart';
import 'package:union_app/src/screens/project/project_details/widgets/open_role_item_widget.dart';
import 'package:union_app/src/theme.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProjectDetailsBloc(FirebaseProjectOpenRoleRepository())
            ..add(GetOpenRoles(project.id!)),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            if(context.read<AppBloc>().state.user.id == project.ownerId)
            Theme(
              data: Theme.of(context).copyWith(
                cardColor: AppColors.backgroundLight1,
                iconTheme: const IconThemeData(color: AppColors.white09),
              ),
              child: PopupMenuButton<String>(
                onSelected: (String choice) =>
                    manageChoices(choice, context, project),
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
          title: Text(project.title ?? ''),
        ),
        body: _ProjectDetailsPage(project: project),
      ),
    );
  }
}

class _ProjectDetailsPage extends StatelessWidget {
  const _ProjectDetailsPage({Key? key, required this.project})
      : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      buildWhen: (ProjectDetailsState previous, ProjectDetailsState current) {
        return previous.openRoles != current.openRoles;
      },
      builder: (BuildContext context, ProjectDetailsState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16),
                const Text('Short Description',
                    style: AppStyles.textStyleHeading1),
                const SizedBox(height: 16),
                Text(project.shortDescription, style: AppStyles.textStyleBody),
                const SizedBox(height: 24),
                const Text('Details', style: AppStyles.textStyleHeading1),
                const SizedBox(height: 16),
                Text(project.details, style: AppStyles.textStyleBody),
                const SizedBox(height: 16),
                if (project.tags!.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      'Tags',
                      style: AppStyles.textStyleHeading1,
                    ),
                  ),
                if (project.tags!.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    children: project.tags!
                        .map(
                          (dynamic tag) => TagWidget(label: tag as String),
                        )
                        .toList()
                        .cast<Widget>(),
                  ),
                if (state.openRoles.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text(
                      'Open roles',
                      style: AppStyles.textStyleHeading1,
                    ),
                  ),
                Flexible(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.openRoles.length,
                    itemBuilder: (BuildContext context, int index) {
                      /*return OpenRoleItemWidget(
                    projectOpenRole: ProjectOpenRole.fromJson(
                        project.openRoles![index] as Map<String, dynamic>),
                    showApplyButton: true,
                  );*/
                      return OpenRoleItemWidget(
                          projectOpenRole: state.openRoles[index],
                          showApplyButton: isNotProjectOwner(project.ownerId, context.read<AppBloc>().state.user.id));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
        style: const TextStyle(
            color: AppColors.backgroundDark, fontWeight: FontWeight.w600),
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      backgroundColor: AppColors.primaryColor,
    );
  }
}

void manageChoices(String choice, BuildContext context, Project project) {
  switch (choice) {
    case Choices.delete:
      showDeleteDialog(context, project);
      break;
    case Choices.edit:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => EditProjectPage(
            project: project,
          ),
        ),
      );
      break;
    case Choices.add_open_role:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              AddOpenRolePage(projectId: project.id!),
        ),
      );
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
        content: const Text('Are you sure you want to delete this project?',
            style: AppStyles.textStyleBody),
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
