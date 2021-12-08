import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/form_inputs/project_title.dart';
import 'package:union_app/src/screens/project/edit_project/bloc/edit_project_bloc.dart';
import 'package:union_app/src/theme.dart';

class TitleInputWidget extends StatelessWidget {
  const TitleInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProjectBloc, EditProjectState>(
      buildWhen: (EditProjectState previous, EditProjectState current) =>
      previous.project.title != current.project.title,
      builder: (BuildContext context, EditProjectState state) {
        return TextFormField(
           initialValue: state.project.title,
          onChanged: (String title) =>
              context.read<EditProjectBloc>().add(TitleChanged(title)),
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            labelText: 'Title *',
            errorText: ProjectTitle.dirty(state.project.title!).invalid ? 'Invalid title' : null,
          ),
        );
      },
    );
  }
}
