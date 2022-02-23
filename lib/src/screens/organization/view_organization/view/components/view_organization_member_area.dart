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
  }) : super(key: key);

  final bool isMember;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          if (!isOwner)
          ElevatedButton(
            onPressed: () {
              if (isMember) {
                context.read<ViewOrganizationBloc>().add(LeaveOrganization());
              } else {
                context.read<ViewOrganizationBloc>().add(JoinOrganization());
              }
            },
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
  }
}
