import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/theme.dart';

import '../../edit_profile.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<EditProfileBloc>().add(UpdateProfile());
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        side: const BorderSide(
          width: 2.0,
          color: AppColors.primaryColor,
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        'Save',
        style: AppStyles.buttonTextStyle,
      ),
    );
  }
}
