import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/screens/project/edit_project/bloc/edit_project_bloc.dart';
import 'package:union_app/src/theme.dart';

class SaveButtonWidget extends StatelessWidget {
  const SaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProjectBloc, EditProjectState>(
      listener: (BuildContext context, EditProjectState state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(HomePage.route());
        }
      },
      builder: (BuildContext context, EditProjectState state) {
        return ElevatedButton(
          onPressed: () {
            context.read<EditProjectBloc>().add(SaveButtonPressed());
          },
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryColor,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            side: const BorderSide(
              width: 2.0,
              color: AppColors.primaryColor,
            ),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text(
            'Save',
            style: TextStyle(
              color: Color.fromRGBO(18, 18, 18, 1),
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}
