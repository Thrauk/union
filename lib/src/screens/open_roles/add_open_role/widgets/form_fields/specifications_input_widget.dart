import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/bloc/add_open_role_bloc.dart';
import 'package:union_app/src/theme.dart';

class SpecificationsInputWidget extends StatelessWidget {
  const SpecificationsInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOpenRoleBloc, AddOpenRoleState>(
      buildWhen: (AddOpenRoleState previous, AddOpenRoleState current) =>
      previous.specifications != current.specifications,
      builder: (BuildContext context, AddOpenRoleState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            maxLines: null,
            minLines: 1,
            onChanged: (String value) =>
                context.read<AddOpenRoleBloc>().add(SpecificationsChanged(value)),
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
            ),
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              labelText: 'Specifications *',
              errorText: state.specifications.invalid ? 'Invalid specifications' : null,
            ),
          ),
        );
      },
    );
  }
}
