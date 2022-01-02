import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/open_roles/open_role_details/bloc/open_role_details_bloc.dart';
import 'package:union_app/src/theme.dart';

class ApplyButtonWidget extends StatelessWidget {
  const ApplyButtonWidget({Key? key, required this.openRoleId})
      : super(key: key);

  final String openRoleId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenRoleDetailsBloc, OpenRoleDetailsState>(
      buildWhen: (OpenRoleDetailsState previous, OpenRoleDetailsState current) {
        return previous.alreadyAppliedToProject !=
            current.alreadyAppliedToProject;
      },
      builder: (BuildContext buildContext, OpenRoleDetailsState state) {
        return ElevatedButton(
          onPressed: () {
            if (state.alreadyAppliedToProject) {
              context.read<OpenRoleDetailsBloc>().add(ApplyButtonPressed(
                  context.read<AppBloc>().state.user.id, openRoleId));
            } else {
              showApplyDialog(buildContext,
                  context.read<AppBloc>().state.user.id, openRoleId);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryColor,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            side: const BorderSide(
              width: 2.0,
              color: AppColors.primaryColor,
            ),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text(
            !state.alreadyAppliedToProject ? 'I want to apply' : 'Applied',
            style: AppStyles.buttonTextStyle,
          ),
        );
      },
    );
  }
}

void showApplyDialog(
    BuildContext dialogContext, String uid, String openRoleId) {
  showDialog(
    context: dialogContext,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: AppColors.backgroundLight,
      content: TextField(
        minLines: 1,
        maxLines: 4,
        onChanged: (String value) {
          dialogContext.read<OpenRoleDetailsBloc>().add(NoticeChanged(value));
        },
        style: const TextStyle(
          color: AppColors.white07,
        ),
        cursorColor: AppColors.primaryColor,
        decoration: const InputDecoration(
          label: Text('Why do you want to apply?'),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryColor,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            side: const BorderSide(
              width: 2.0,
              color: AppColors.primaryColor,
            ),
          ),
          onPressed: () {
            dialogContext
                .read<OpenRoleDetailsBloc>()
                .add(ApplyButtonPressed(uid, openRoleId));
            Navigator.of(context).pop();
          },
          child: const Text(
            'Apply',
            style: AppStyles.buttonTextStyle,
          ),
        ),
      ],
    ),
  );
}
