import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/edit_profile/edit_profile.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<EditProfileBloc>().add(UpdateProfile());
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: Colors.transparent,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        side: const BorderSide(
          width: 2.0,
          color: Colors.white,
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}
