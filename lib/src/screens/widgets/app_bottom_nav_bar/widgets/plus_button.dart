import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:union_app/src/screens/article/create_article/view/create_article_page.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/view/create_organization_page.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/theme.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      buttonSize: const Size(32, 32),
      overlayColor: AppColors.backgroundLight,
      icon: Icons.add,
      backgroundColor: AppColors.primaryColor,
      spacing: 8,
      spaceBetweenChildren: 8,
      children: [
        SpeedDialChild(label: 'Organization', onTap: () => Navigator.of(context).push(CreateOrganizationPage.route())),
        SpeedDialChild(label: 'Project', onTap: () => Navigator.of(context).push(CreateProjectPage.route())),
        SpeedDialChild(label: 'Article', onTap: () => Navigator.of(context).push(CreateArticlePage.route())),
      ],
    );
  }
}
