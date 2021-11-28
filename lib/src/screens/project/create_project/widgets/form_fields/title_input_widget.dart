import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/project/project.dart';
import 'package:union_app/src/theme.dart';

class TitleInputWidget extends StatelessWidget {
  const TitleInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProjectBloc, CreateProjectState>(
      buildWhen: (CreateProjectState previous, CreateProjectState current) =>
          previous.title != current.title,
      builder: (BuildContext context, CreateProjectState state) {
        return TextField(
          onChanged: (String title) =>
              context.read<CreateProjectBloc>().add(TitleChanged(title)),
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            labelText: 'Title *',
            helperText: '',
            errorText: state.title.invalid ? 'Invalid title' : null,
          ),
        );
      },
    );
  }
}
