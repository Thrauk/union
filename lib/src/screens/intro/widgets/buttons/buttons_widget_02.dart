import 'package:flutter/material.dart';
import 'package:union_app/src/screens/auth/sign_up/sign_up.dart';
import 'package:union_app/src/theme.dart';

class ButtonsWidget02 extends StatelessWidget {
  const ButtonsWidget02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      style: ElevatedButton.styleFrom(
          primary: AppColors.primaryColor,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
          side: const BorderSide(
            width: 2.0,
            color: AppColors.primaryColor,
          ),
          minimumSize: const Size(double.infinity, double.infinity)),
      child: const Text(
        'Get started',
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
