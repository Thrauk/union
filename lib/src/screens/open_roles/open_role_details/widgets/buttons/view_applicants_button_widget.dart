import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/open_roles/view_open_role_applicants/view/open_role_applicants_page.dart';
import 'package:union_app/src/theme.dart';

class ViewApplicantsButtonWidget extends StatelessWidget {
  const ViewApplicantsButtonWidget({Key? key, required this.openRole}) : super(key: key);

  final ProjectOpenRole openRole;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () {
        Navigator.push(context, OpenRoleApplicantsPage.route(openRole));
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        side: const BorderSide(
          width: 2.0,
          color: AppColors.primaryColor,
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
      child: const Text(
        'View applicants',
        style: AppStyles.buttonTextStyle,
      ),
    );
  }
}
