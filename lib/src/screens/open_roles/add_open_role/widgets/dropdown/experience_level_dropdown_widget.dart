// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/bloc/add_open_role_bloc.dart';
import 'package:union_app/src/theme.dart';

class ExperienceLevelDropdownWidget extends StatelessWidget {
  const ExperienceLevelDropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOpenRoleBloc, AddOpenRoleState>(
      buildWhen: (AddOpenRoleState previous, AddOpenRoleState current){
        return previous.selectedExperienceLevel != current.selectedExperienceLevel;
      },
      builder: (BuildContext context, AddOpenRoleState state) {
        return Column(
          children: [
            const Text('Experience level', style: AppStyles.textStyleHeading1,),
            DropdownButton(
              value: state.selectedExperienceLevel,
              items: state.experienceLevels
                  .map(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: AppStyles.textStyleBody,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                context.read<AddOpenRoleBloc>().add(ExperienceLevelChanged(value!));
              },
            ),
          ],
        );
      },
    );
  }
}
