import 'package:flutter/material.dart';

import '../../../../../theme.dart';

class SingleLineGenericField extends StatelessWidget {
  const SingleLineGenericField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.errorText,
  }) : super(key: key);

  final Function(String) onChanged;
  final String labelText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //keyboardType: TextInputType.multiline,
      style: AppStyles.textStyleBody,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
      ),
    );
  }
}
