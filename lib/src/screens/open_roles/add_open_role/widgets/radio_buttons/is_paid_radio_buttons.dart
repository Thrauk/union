import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/bloc/add_open_role_bloc.dart';
import 'package:union_app/src/theme.dart';

class IsPaidRadioButtonsWidget extends StatelessWidget {
  const IsPaidRadioButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOpenRoleBloc, AddOpenRoleState>(
      buildWhen: (AddOpenRoleState previous, AddOpenRoleState current) =>
          previous.isPaid != current.isPaid,
      builder: (BuildContext context, AddOpenRoleState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              ListTile(
                leading: Radio(
                  value: true,
                  groupValue: state.isPaid,
                  onChanged: (_) {
                    context.read<AddOpenRoleBloc>().add(IsPaidChanged(true));
                  },
                  activeColor: AppColors.primaryColor,
                ),
                title: const Text(
                  'Paid',
                  style: AppStyles.textStyleBody,
                ),
              ),
              ListTile(
                leading: Radio(
                  value: false,
                  groupValue: state.isPaid,
                  onChanged: (_) {
                    context.read<AddOpenRoleBloc>().add(IsPaidChanged(false));
                  },
                  activeColor: AppColors.primaryColor,
                ),
                title: const Text('Not-Paid', style: AppStyles.textStyleBody),
              ),
            ],
          ),
        );
      },
    );
  }
}
