import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/login/login.dart';
import 'package:union_app/src/theme.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<LoginCubit>().logInWithCredentials();
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        side: const BorderSide(
          width: 2.0,
          color: AppColors.primaryColor,
        ),
        maximumSize: const Size(double.infinity, 48),
        minimumSize: const Size(double.infinity, 48),
      ),
      child: const Text(
        'Log In',
        style: TextStyle(
          color: Color.fromRGBO(18, 18, 18, 1),
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}
