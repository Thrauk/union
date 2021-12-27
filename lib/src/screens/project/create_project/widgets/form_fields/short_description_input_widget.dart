import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/theme.dart';

class ShortDescriptionInputWidget extends StatelessWidget {
  const ShortDescriptionInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProjectBloc, CreateProjectState>(
      buildWhen: (CreateProjectState previous, CreateProjectState current) =>
          previous.shortDescription != current.shortDescription,
      builder: (BuildContext context, CreateProjectState state) {
        return TextField(
          minLines: 1,
          maxLines: null,
          style: const TextStyle(
            color: AppColors.white07,
          ),
          onChanged: (String shortDescription) => context
              .read<CreateProjectBloc>()
              .add(ShortDescriptionChanged(shortDescription)),
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            labelText: 'Short description *',
            errorText: state.shortDescription.invalid
                ? 'Invalid short description'
                : null,
          ),
        );
      },
    );
  }
}
