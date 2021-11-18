import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class TitleInputWidget extends StatelessWidget {
  const TitleInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.8),
      ),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: 'Title *',
        helperText: '',
        errorText: null,
      ),
    );
  }
}
