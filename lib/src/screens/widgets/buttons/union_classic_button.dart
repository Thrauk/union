import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class UnionClassicButton extends StatelessWidget {
  const UnionClassicButton({
    Key? key,
    this.onPressed,
    this.primaryColor = AppColors.primaryColor,
    this.onSurface = Colors.transparent,
    this.shadowColor = Colors.transparent,
    this.minimumSize = const Size(double.infinity, 50),
    this.text = '',
    this.textStyle = AppStyles.buttonTextStyle,
    this.borderWidth = 2.0,
    this.borderColor = AppColors.primaryColor,
    this.hasBorder = true,
  }) : super(key: key);

  final void Function()? onPressed;
  final Color primaryColor;
  final Color onSurface;
  final Color shadowColor;
  final Size minimumSize;
  final String text;
  final TextStyle textStyle;
  final double borderWidth;
  final Color borderColor;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onSurface: onSurface,
        shadowColor: shadowColor,
        side: hasBorder
            ? BorderSide(
                width: borderWidth,
                color: borderColor,
              )
            : null,
        minimumSize: minimumSize,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
