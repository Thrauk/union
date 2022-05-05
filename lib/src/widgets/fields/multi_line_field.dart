import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';


class MultiLineField extends StatelessWidget {
  const MultiLineField({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.errorText,
    this.initialText,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;
  final String? errorText;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      initialValue: initialText,
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
