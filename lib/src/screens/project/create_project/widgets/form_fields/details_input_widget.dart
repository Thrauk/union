import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/theme.dart';

class DetailsInputWidget extends StatelessWidget {
  const DetailsInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProjectCubit, CreateProjectState>(
      buildWhen: (CreateProjectState previous, CreateProjectState current) =>
          previous.details != current.details,
      builder: (BuildContext context, CreateProjectState state) {
        return TextField(
          minLines: 1,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(
            color: AppColors.white07,
          ),
          onChanged: (String details) =>
              context.read<CreateProjectCubit>().detailsChanged(details),
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            labelText: 'Details *',
            helperText: '',
            errorText: state.details.invalid ? 'Invalid details' : null,
          ),
        );
      },
    );
  }
}
