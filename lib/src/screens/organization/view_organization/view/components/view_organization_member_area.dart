import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/organization/view_organization/bloc/view_organization_bloc.dart';
import 'package:union_app/src/theme.dart';

class ViewOrganizationMemberArea extends StatelessWidget {
  const ViewOrganizationMemberArea({
    Key? key,
    required this.isMember,
    required this.isOwner,
    required this.isPublic,
    required this.isRequested,
    this.onLeaveJoinPressed,
    this.onRequestPressed,
  }) : super(key: key);

  final bool isMember;
  final bool isOwner;
  final bool isPublic;
  final bool isRequested;
  final void Function()? onLeaveJoinPressed;
  final void Function()? onRequestPressed;

  @override
  Widget build(BuildContext context) {
    if (isMember || isPublic)
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[
            if (!isOwner)
              ElevatedButton(
                onPressed: onLeaveJoinPressed,
                style: ElevatedButton.styleFrom(
                  primary: AppColors.backgroundLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  isMember ? 'Leave' : 'Join',
                  style: isMember ? AppStyles.textStyleBodyRed : AppStyles.textStyleBodyPrimary,
                ),
              ),
          ],
        ),
      );
    else if(!isOwner) {
      return ElevatedButton(
        onPressed: onRequestPressed,
        style: ElevatedButton.styleFrom(
          primary: AppColors.backgroundLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          !isRequested ? 'Request join' : 'Requested',
          style: isRequested ? AppStyles.textStyleBodyRed : AppStyles.textStyleBodyPrimary,
        ),
      );
    }
    return Container();
  }
}
