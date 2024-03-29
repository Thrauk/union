import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/widgets/user_item/user_item_widget.dart';
import 'package:union_app/src/theme.dart';

import 'bloc/project_members_bloc.dart';

class MemberItemWidget extends StatelessWidget {
  const MemberItemWidget({Key? key, required this.user, required this.ownerId, required this.projectId}) : super(key: key);

  final FullUser user;
  final String ownerId;
  final String projectId;

  @override
  Widget build(BuildContext context) {
    final String loggedUid = context.read<AppBloc>().state.user.id;
    return BlocBuilder<ProjectMembersBloc, ProjectMembersState>(
      buildWhen: (ProjectMembersState previous, ProjectMembersState current) {
        return previous.users.length == current.users.length;
      },
      builder: (BuildContext context, ProjectMembersState state) {
        if ((loggedUid == ownerId) && (loggedUid != user.id))
          return UserItemWidget(
            user: user,
            endWidget: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  showDeleteDialog(context, user, projectId);
                },
                child: const Icon(
                  Icons.person_remove_alt_1,
                  color: AppColors.redLight,
                ),
              ),
            ),
          );
        else
          return UserItemWidget(user: user);
      },
    );
  }
}

void showDeleteDialog(BuildContext context, FullUser user, String projectId) {
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
              context.read<ProjectMembersBloc>().add(DeleteMemberPressed(user.id, projectId));
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
        content: Text('Are you sure you want remove ${user.displayName} from the project?', style: AppStyles.textStyleBody),
      ),
    ),
  );
}
