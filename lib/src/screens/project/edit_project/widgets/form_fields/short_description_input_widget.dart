import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/form_inputs/project_body.dart';
import 'package:union_app/src/screens/project/edit_project/bloc/edit_project_bloc.dart';
import 'package:union_app/src/theme.dart';

class ShortDescriptionInputWidget extends StatelessWidget {
  const ShortDescriptionInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProjectBloc, EditProjectState>(
      buildWhen: (EditProjectState previous, EditProjectState current) =>
          previous.project.shortDescription != current.project.shortDescription,
      builder: (BuildContext context, EditProjectState state) {
        return TextFormField(
          initialValue: state.project.shortDescription,
          minLines: 1,
          maxLines: null,
          style: const TextStyle(
            color: AppColors.white07,
          ),
          onChanged: (String shortDescription) => context
              .read<EditProjectBloc>()
              .add(ShortDescriptionChanged(shortDescription)),
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            labelText: 'Short description *',
            errorText: ProjectBody.dirty(state.project.shortDescription).invalid
                ? 'Invalid short description'
                : null,
          ),
        );
      },
    );
  }
}
