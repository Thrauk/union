import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/bloc/add_open_role_bloc.dart';
import 'package:union_app/src/theme.dart';

class RemoteSwitchButtonWidget extends StatelessWidget {
  const RemoteSwitchButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOpenRoleBloc, AddOpenRoleState>(
      buildWhen: (AddOpenRoleState previous, AddOpenRoleState current) =>
          previous.isRemotePossible != current.isRemotePossible,
      builder: (BuildContext context, AddOpenRoleState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              const Text('Is remote work possible',
                  style: AppStyles.textStyleBodyBig),
              const SizedBox(width: 6),
              Switch(
                inactiveTrackColor: AppColors.white02,
                activeColor: AppColors.primaryColor,
                value: state.isRemotePossible,
                onChanged: (bool value) {
                    context
                        .read<AddOpenRoleBloc>()
                        .add(IsRemotePossibleChanged(value));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
