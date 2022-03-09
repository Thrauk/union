import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';


class MultiLineGenericField extends StatelessWidget {
  const MultiLineGenericField({
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
      minLines: 1,
      maxLines: 10,
      keyboardType: TextInputType.multiline,
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