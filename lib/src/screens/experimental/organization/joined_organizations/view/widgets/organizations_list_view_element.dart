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
                    height: 120,
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
            // const SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        organization.name,
                        style: AppStyles.textStyleHeading1,
                      ),
                      const SizedBox(width: 4),
                      if (organization.ownerId == loggedUid)
                        const Icon(
                          Icons.whatshot,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        organization.location,
                        style: AppStyles.textStyleBody,
                      ),
                      const Text(
                        ' • ',
                        style: AppStyles.textStyleBodySmall,
                      ),
                      Text(
                        organization.category,
                        style: AppStyles.textStyleBody,
                      ),
                      const Text(
                        ' • ',
                        style: AppStyles.textStyleBodySmall,
                      ),
                      Text(
                        organization.type,
                        style: AppStyles.textStyleBody,
                      ),
                    ],
                  ),
                      const SizedBox(height: 4),
                      Text(
                        organization.members.length > 1
                            ? '${organization.members.length} members'
                            : '${organization.members.length} member',
                        style: AppStyles.textStyleBodySmall,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
