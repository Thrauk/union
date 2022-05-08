import 'package:flutter/material.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class InviteButton extends StatelessWidget {
  const InviteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return UnionClassicButton(
      primaryColor: AppColors.backgroundLight,
      minimumSize: const Size(0, 28),
      text: 'Invite',
      textStyle: AppStyles.buttonTextStyle.copyWith(fontSize: 14),
      onPressed: () => onPressed(),
    );
  }
}
