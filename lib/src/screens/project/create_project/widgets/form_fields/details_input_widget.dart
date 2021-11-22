import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class DetailsInputWidget extends StatelessWidget {
  const DetailsInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.8),
      ),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: 'Details *',
        helperText: '',
        errorText: null,
      ),
    );
  }
}
