import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/organization/organization_members/view/organization_members_page.dart';
import 'package:union_app/src/theme.dart';

class OrganizationInfo extends StatelessWidget {
  const OrganizationInfo({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            organization.name,
            style: AppStyles.textStyleHeading2,
          ),
          // if (isOwned)
          //   const Icon(
          //     Icons.person,
          //     color: AppColors.primaryColor,
          //   ),
        ],
      ),
      const SizedBox(height: 8),
      Text(organization.description, style: AppStyles.textStyleBody),
      const SizedBox(height: 12),
      Row(
        children: <Widget>[
          if (organization.type == 'Public')
            const Icon(
              Icons.lock_open,
              color: AppColors.white07,
              size: 20,
            )
          else
            const Icon(
              Icons.lock_outlined,
              color: AppColors.white07,
              size: 20,
            ),
          const SizedBox(width: 2),
          Text(
            organization.type,
            style: AppStyles.textStyleBodySmall,
          ),
          const Text(' • ', style: AppStyles.textStyleBodySmall),
          Text(
            organization.category,
            style: AppStyles.textStyleBodySmall,
          ),
          const Text(' • ', style: AppStyles.textStyleBodySmall),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(OrganizationMembersPage.route(organization.id));
            },
            child: Text(
              organization.members.length > 1
                  ? '${organization.members.length} members'
                  : '${organization.members.length} member',
              style: AppStyles.textStyleBodySmallW08,
            ),
          ),
        ],
      ),
    ]);
  }
}
