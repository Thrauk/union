import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class ChipWithTextAndDeleteButton extends StatelessWidget {
  const ChipWithTextAndDeleteButton({Key? key, required this.label, required this.onDeleted  }) : super(key: key);

  final String label;
  final void Function() onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
            color: AppColors.backgroundDark, fontWeight: FontWeight.w600),
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      onDeleted:  onDeleted,
      backgroundColor: AppColors.primaryColor,
    );
  }
}
