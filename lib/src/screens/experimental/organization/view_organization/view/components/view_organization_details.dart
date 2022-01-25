import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/experimental/models/organization.dart';
import 'package:union_app/src/screens/experimental/organization/manage_organization/add_member/view/add_member_organization.dart';
import 'package:union_app/src/screens/experimental/organization/organization_members/view/organization_members_page.dart';
import 'package:union_app/src/screens/experimental/organization/view_organization/bloc/view_organization_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/view_organization/view/components/view_organization_member_area.dart';

import '../../../../../../theme.dart';

class ViewOrganizationDetails extends StatelessWidget {
  const ViewOrganizationDetails({
    Key? key,
    required this.organization,
    required this.isOwned,
    required this.isMember,
    required this.isPublic,
  }) : super(key: key);

  final Organization organization;
  final bool isOwned;
  final bool isMember;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (organization.photoUrl != '')
            SizedBox(
              height: 120,
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
                    if (isOwned)
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(OrganizationMembersPage.route(organization.id));
                  },
                  child: Text(
                    'Members: ${organization.members.length}',
                    style: AppStyles.textStyleBodySmall,
                  ),
                ),
                if (isMember || isPublic)
                  ViewOrganizationMemberArea(
                    isMember: isMember,
                    isOwner: isOwned,
                  ),
                if (isOwned)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(AddMemberOrganization.route(organization.id)).then( (dynamic response) =>
                          context.read<ViewOrganizationBloc>().add(LoadData())
                      );
                    },
                    child: const Text('Add member'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
