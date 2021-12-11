import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme.dart';

enum StatButton { LeftRounded, NoRounded, RightRounded }

const Radius borderRadius = Radius.circular(20);
const List<BorderRadiusGeometry> borderRadiusGeometry = <BorderRadiusGeometry>[
  BorderRadius.only(
    topLeft: borderRadius,
    bottomLeft: borderRadius,
  ),
  BorderRadius.zero,
  BorderRadius.only(
    topRight: borderRadius,
    bottomRight: borderRadius,
  ),
];

class ProfileStatElementWidget extends StatelessWidget {
  const ProfileStatElementWidget({Key? key, this.onPressed, required this.buttonType, this.title, this.data}) : super(key: key);

  final VoidCallback? onPressed;
  final StatButton buttonType;
  final String? title;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, double.infinity),
        shadowColor: Colors.transparent,
        primary: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusGeometry[buttonType.index]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            data ?? '',
            style: AppStyles.buttonTextStylePrimaryColor,
          ),
          Text(
            title ?? '',
            style: AppStyles.textStyleBody,
          ),
        ],
      ),
    );
  }
}
