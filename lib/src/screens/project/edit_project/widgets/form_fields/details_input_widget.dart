import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/form_inputs/project_body.dart';
import 'package:union_app/src/screens/project/edit_project/edit_project.dart';
import 'package:union_app/src/theme.dart';

class DetailsInputWidget extends StatelessWidget {
  const DetailsInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProjectBloc, EditProjectState>(
      buildWhen: (EditProjectState previous, EditProjectState current) =>
          previous.project.details != current.project.details,
      builder: (BuildContext context, EditProjectState state) {
        return TextFormField(
          initialValue: state.project.details,
          minLines: 1,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(
            color: AppColors.white07,
          ),
          onChanged: (String details) =>
              context.read<EditProjectBloc>().add(DetailsChanged(details)),
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            labelText: 'Details *',
            errorText: ProjectBody.dirty(state.project.details).invalid
                ? 'Invalid details'
                : null,
          ),
        );
      },
    );
  }
}
