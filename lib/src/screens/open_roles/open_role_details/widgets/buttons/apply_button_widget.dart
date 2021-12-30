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
      buildWhen: (OpenRoleDetailsState previous, OpenRoleDetailsState current){
        return previous.alreadyAppliedToProject != current.alreadyAppliedToProject;
      },
      builder: (BuildContext context, OpenRoleDetailsState state) {
        return ElevatedButton(
          onPressed: () {
            context.read<OpenRoleDetailsBloc>().add(ApplyButtonPressed(context
                .read<AppBloc>()
                .state
                .user
                .id, openRoleId));
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
            !state.alreadyAppliedToProject ? 'Apply now' : 'Applied',
            style: AppStyles.buttonTextStyle,
          ),
        );
      },
    );
  }
}
