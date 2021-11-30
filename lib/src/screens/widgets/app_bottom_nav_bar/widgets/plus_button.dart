import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/theme.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      buttonSize: 32,
      overlayColor: AppColors.backgroundLight,
      icon: Icons.add,
      backgroundColor: AppColors.primaryColor,
      spacing: 8,
      spaceBetweenChildren: 8,
      children: [
        SpeedDialChild(label: 'Organization'),
        SpeedDialChild(
            label: 'Project',
            onTap: () => Navigator.of(context).push(CreateProjectPage.route())),
        SpeedDialChild(label: 'Article'),
      ],
    );
  }
}