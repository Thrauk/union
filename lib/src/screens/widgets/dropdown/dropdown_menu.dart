import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class DropdownMenu extends StatelessWidget {
  const DropdownMenu({
    Key? key,
    this.onChanged,
    required this.items,
    this.isError = false,
    this.selectedValue,
    this.hint = '',
  }) : super(key: key);

  final void Function(String?)? onChanged;
  final List<String> items;
  final bool isError;
  final String? selectedValue;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DropdownButton<String>(
        hint: Text(
          hint,
          style: AppStyles.textStyleBodyPrimary,
        ),
        value: selectedValue,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.primaryColor,
        ),
        elevation: 16,
        style: AppStyles.textStyleBodyPrimary,
        underline: Container(
          height: 2,
          color: !isError ? AppColors.primaryColor : Colors.red,
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
