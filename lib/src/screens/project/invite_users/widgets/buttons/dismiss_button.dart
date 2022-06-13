import 'package:flutter/material.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class DismissButton extends StatelessWidget {
  const DismissButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return UnionClassicButton(
      primaryColor: Colors.transparent,
      borderColor: Colors.transparent,
      minimumSize: const Size(0, 28),
      text: 'Dismiss',
      textStyle: AppStyles.buttonTextStyle.copyWith(fontSize: 14, color: AppColors.primaryColor),
      onPressed: () => onPressed(),
    );
  }
}
