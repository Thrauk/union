import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/bloc/add_open_role_bloc.dart';
import 'package:union_app/src/theme.dart';

class TitleInputWidget extends StatelessWidget {
  const TitleInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOpenRoleBloc, AddOpenRoleState>(
      buildWhen: (AddOpenRoleState previous, AddOpenRoleState current) =>
          previous.title != current.title,
      builder: (BuildContext context, AddOpenRoleState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            onChanged: (String value) =>
                context.read<AddOpenRoleBloc>().add(TitleChanged(value)),
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
            ),
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              labelText: 'Role title *',
              errorText: state.location.invalid ? 'Invalid role title' : null,
            ),
          ),
        );
      },
    );
  }
}
