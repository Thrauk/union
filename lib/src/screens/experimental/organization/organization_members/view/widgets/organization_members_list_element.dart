import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/experimental/organization/organization_members/bloc/organization_members_bloc.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/profile/profile.dart';

import '../../../../../../theme.dart';

class OrganizationMembersListElement extends StatelessWidget {
  const OrganizationMembersListElement({Key? key, required this.user, required this.loggedUid, required this.isOwner}) : super(key: key);

  final FullUser user;
  final String loggedUid;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(ProfilePage.route(uid: user.id));
      },
      child: Card(
        color: AppColors.backgroundDark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Avatar(
                    photo: user.photo,
                    avatarSize: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.displayName ?? '',
                          style: AppStyles.textStyleBody,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user.jobTitle ?? '',
                          style: AppStyles.textStyleBodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isOwner)
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      showDeleteDialog(context, user);
                      // context.read<OrganizationMembersBloc>().add(RemoveMember(memberUid: user.id));
                    },
                    child: const Icon(
                      Icons.person_remove_alt_1,
                      color: AppColors.redLight,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

void showDeleteDialog(BuildContext context, FullUser user) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) => Center(
      child: AlertDialog(
        elevation: 20,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.primaryColor,
            ),
            onPressed: () {
              context.read<OrganizationMembersBloc>().add(RemoveMember(memberUid: user.id));
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              'Yes',
              style: AppStyles.textStyleBody.merge(
                const TextStyle(color: AppColors.backgroundLight, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'No',
              style: AppStyles.textStyleBody.merge(
                const TextStyle(color: AppColors.redLight),
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.backgroundLight,
        title: const Text('Hold on!', style: AppStyles.textStyleHeading1),
        content:
            Text('Are you sure you want remove ${user.displayName} from the organization?', style: AppStyles.textStyleBody),
      ),
    ),
  );
}
