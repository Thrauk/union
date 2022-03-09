import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/organization/manage_organization/add_member/bloc/add_member_organization_bloc.dart';
import 'package:union_app/src/screens/user_profile/profile/profile.dart';
import 'package:union_app/src/theme.dart';



class ResultListElement extends StatelessWidget {
  const ResultListElement({Key? key, required this.user, required this.isMember}) : super(key: key);

  final FullUser user;
  final bool isMember;

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
                        ),
                        Text(
                          user.jobTitle ?? '',
                          style: AppStyles.textStyleBodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (!isMember)
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        context.read<AddMemberOrganizationBloc>().add(AddMemberPressed(
                              memberId: user.id,
                            ));
                      },
                      child: const Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                      )),
                )
              else
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.group,
                    color: AppColors.primaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
