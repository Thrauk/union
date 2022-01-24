import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/screens/experimental/models/organization.dart';

import '../../../../../../theme.dart';

class OrganizationListViewElement extends StatelessWidget {
  const OrganizationListViewElement({
    Key? key,
    required this.organization,
    required this.loggedUid,
  }) : super(key: key);

  final Organization organization;
  final String loggedUid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: AppColors.backgroundLight1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (organization.photoUrl != '')
              SizedBox(
                height: 70,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: organization.photoUrl,
                  fit: BoxFit.fitWidth,
                ),
              )
            else
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 70,
                    width: double.infinity,
                    color: AppColors.primaryColor,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.group,
                      color: AppColors.black09,
                      size: 35,
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        organization.name,
                        style: AppStyles.textStyleBodyPrimary,
                      ),
                      if (organization.ownerId == loggedUid)
                        Icon(
                          Icons.blender,
                          color: AppColors.primaryColor,
                        ),
                    ],
                  ),
                  Text(
                    organization.category,
                    style: AppStyles.textStyleBodySmall,
                  ),
                  Text(
                    organization.type,
                    style: AppStyles.textStyleBodySmall,
                  ),
                  Text(
                    'Members: ${organization.members.length}',
                    style: AppStyles.textStyleBodySmall,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
