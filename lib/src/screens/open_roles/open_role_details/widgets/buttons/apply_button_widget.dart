import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class ApplyButtonWidget extends StatelessWidget {
  const ApplyButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
        'Apply now',
        style: AppStyles.buttonTextStyle,
      ),
    );
  }
}
