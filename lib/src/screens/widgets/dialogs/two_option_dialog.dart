import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

// ignore: avoid_classes_with_only_static_members
class TwoOptionsDialog {
  static void showTwoOptionsDialog({
    required BuildContext context,
    void Function()? optionOneFunction,
    void Function()? optionTwoFunction,
    String dialogTitle = 'Hold On!',
    String dialogSubtitle = '',
    String buttonOneTitle = 'Yes',
    String buttonTwoTitle = 'No',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(
        child: AlertDialog(
          elevation: 20,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
              ),
              onPressed: optionOneFunction,
              child: Text(
                buttonOneTitle,
                style: AppStyles.textStyleBody.merge(
                  const TextStyle(color: AppColors.backgroundLight, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => optionTwoFunction ?? Navigator.of(context).pop(),
              child: Text(
                buttonTwoTitle,
                style: AppStyles.textStyleBody.merge(
                  const TextStyle(color: AppColors.redLight),
                ),
              ),
            ),
          ],
          backgroundColor: AppColors.backgroundLight,
          content:  Text(dialogSubtitle, style: AppStyles.textStyleBody),
          title:  Text(dialogTitle, style: AppStyles.textStyleHeading1),
        ),
      ),
    );
  }
}
