import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/experimental/organization/view_organization/bloc/view_organization_bloc.dart';

import '../../../../../../theme.dart';

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
    return Column(
      children: <Widget>[
        if (!isOwner)
          TextButton(
            onPressed: () {
              if (isMember) {
                context.read<ViewOrganizationBloc>().add(LeaveOrganization());
              } else {
                context.read<ViewOrganizationBloc>().add(JoinOrganization());
              }
            },
            child: Text(
              isMember ? 'Leave' : 'Join',
              style: AppStyles.textStyleBodyPrimary,
            ),
          ),
      ],
    );
  }
}
