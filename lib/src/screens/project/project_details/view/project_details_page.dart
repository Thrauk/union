import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/theme.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return Choices.choices.map(
                (String choice) {
                  return PopupMenuItem(value: choice, child: Text(choice));
                },
              ).toList();
            },
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

class Choices {
  static const String edit = 'Edit';
  static const String delete = 'Delete';

  static const List<String> choices = <String>[edit, delete];
}
