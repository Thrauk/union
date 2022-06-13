import 'package:flutter/material.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class OrganizationEditButtons extends StatelessWidget {
  const OrganizationEditButtons({
    Key? key,
    this.cancelOnPressed,
    this.saveOnPressed,
  }) : super(key: key);

  final void Function()? cancelOnPressed;
  final void Function()? saveOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: UnionClassicButton(
            onPressed: cancelOnPressed,
            primaryColor: Colors.transparent,
            text: 'Cancel',
            textStyle: AppStyles.buttonTextStylePrimaryColor,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: UnionClassicButton(
            onPressed: saveOnPressed,
            text: 'Save',
            textStyle: AppStyles.buttonTextStyle,
          ),
        ),
      ],
    );
  }
}
