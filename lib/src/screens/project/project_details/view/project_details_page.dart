import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/theme.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({Key? key, required this.project}) : super(key: key);

  final Project project;

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
    );
  }
}

class _ProjectDetailsPage extends StatelessWidget {
  const _ProjectDetailsPage({Key? key, required this.project})
      : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          const Text('Short Description', style: AppStyles.textStyleHeading1),
          const SizedBox(height: 16),
          Text(project.shortDescription, style: AppStyles.textStyleBody),
          const SizedBox(height: 24),
          const Text('Details', style: AppStyles.textStyleHeading1),
          const SizedBox(height: 16),
          Text(project.details, style: AppStyles.textStyleBody),
          const SizedBox(height: 16),
          if (project.tags!.isNotEmpty)
            Wrap(
              spacing: 4,
              children: project.tags!
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
  if (choice == Choices.delete) {
    showDeleteDialog(context, project);
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
                    ProfilePage.route(), (Route<dynamic> route) => false);
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

  static const List<String> choices = <String>[edit, delete];
}
