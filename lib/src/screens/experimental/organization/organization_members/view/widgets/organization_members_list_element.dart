import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/profile/profile.dart';

import '../../../../../../theme.dart';

class OrganizationMembersListElement extends StatelessWidget {
  const OrganizationMembersListElement({Key? key, required this.user, required this.loggedUid}) : super(key: key);


  final FullUser user;
  final String loggedUid;

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
            children: <Widget>[
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
                    ),
                    Text(
                      user.jobTitle ?? '',
                      style: AppStyles.textStyleBodySmall,
                    ),

                  ],
                ),
              ),
              if(loggedUid != user.id) Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.remove_circle, color: AppColors.primaryColor,),
              ) else Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.blender, color: AppColors.primaryColor,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}