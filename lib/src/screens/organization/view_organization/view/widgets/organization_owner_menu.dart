import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class OrganizationOwnerMenu extends StatelessWidget {
  const OrganizationOwnerMenu({
    Key? key,
    this.onCreateProjectPressed,
    this.onAddMemberPressed,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  final void Function()? onCreateProjectPressed;
  final void Function()? onAddMemberPressed;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
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
        ElevatedButton.icon(
          icon: const Icon(
            Icons.person_add_alt_1_sharp,
            color: AppColors.primaryColor,
            size: 20.0,
          ),
          label: const Text(
            'Add members',
            style: AppStyles.textStyleBodySmallW08,
          ),
          onPressed: onAddMemberPressed,
          style: ElevatedButton.styleFrom(
            primary: AppColors.backgroundLight1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.edit,
            color: AppColors.primaryColor,
            size: 20.0,
          ),
          label: const Text(
            'Edit',
            style: AppStyles.textStyleBodySmallW08,
          ),
          onPressed: onEditPressed,
          style: ElevatedButton.styleFrom(
            primary: AppColors.backgroundLight1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.delete,
            color: AppColors.primaryColor,
            size: 20.0,
          ),
          label: const Text(
            'Delete organization',
            style: AppStyles.textStyleBodySmallW08,
          ),
          onPressed: onDeletePressed,
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
