import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/view/project_item_widget.dart';
import 'package:union_app/src/theme.dart';

class OrganizationPostsArea extends StatelessWidget {
  const OrganizationPostsArea({Key? key, required this.projects, this.isMember = false, this.isPublic = false,})
      : super(key: key);

  final List<Project> projects;
  final bool isMember;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    if (isMember || isPublic)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Projects', style: AppStyles.textStyleHeading1),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: projects.length,
              itemBuilder: (BuildContext context, int index) {
                return ProjectItemWidget(
                  project: projects[index],
                );
              },
            ),
          ],
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.lock, color: AppColors.primaryColor),
              SizedBox(height: 8),
              Text('The posts of this organizations are private', style: AppStyles.textStyleBody),
            ],
          ),
        ),
      );
  }

}