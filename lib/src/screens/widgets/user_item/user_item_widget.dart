import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/theme.dart';

class UserItemWidget extends StatelessWidget {
  const UserItemWidget({Key? key, required this.user, this.onTap, this.endWidget}) : super(key: key);

  final FullUser user;
  final Function(FullUser user)? onTap;
  final Widget? endWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null)
          onTap!(user);
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
              if (endWidget != null) endWidget!
            ],
          ),
        ),
      ),
    );
  }
}
