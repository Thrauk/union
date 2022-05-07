import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class OrganizationMemberMenu extends StatelessWidget {
  const OrganizationMemberMenu({
    Key? key,
    this.onCreateProjectPressed,
  }) : super(key: key);

  final void Function()? onCreateProjectPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton.icon(
          icon: const Icon(
            Icons.analytics,
            color: AppColors.primaryColor,
            size: 20.0,
          ),
          label: const Text(
            'Create project',
            style: AppStyles.textStyleBodySmallW08,
          ),
          onPressed: onCreateProjectPressed,
          style: ElevatedButton.styleFrom(
            primary: AppColors.backgroundLight1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }
}
