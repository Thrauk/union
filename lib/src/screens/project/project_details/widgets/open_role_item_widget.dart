import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/theme.dart';
import 'package:union_app/src/util/date_format_utils.dart';

class OpenRoleItemWidget extends StatelessWidget {
  const OpenRoleItemWidget(
      {Key? key, required this.projectOpenRole, required this.showApplyButton})
      : super(key: key);

  final ProjectOpenRole projectOpenRole;
  final bool showApplyButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    projectOpenRole.title,
                    style: AppStyles.textStyleBodyBig,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'posted on ${DateFormatUtils.timestampToDate(projectOpenRole.timestamp)}',
                    style: AppStyles.textStyleBodySmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        color: AppColors.white07,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        projectOpenRole.location.split(' ').join(', '),
                        style: AppStyles.textStyleBody,
                      ),
                      if (projectOpenRole.isRemotePossible == true)
                        const Text('•')
                      else
                        const Text(''),
                      if (projectOpenRole.isRemotePossible == true)
                        const Text('Remote')
                      else
                        const Text(''),
                    ],
                  )
                ],
              ),
            ),
            if (showApplyButton == true)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(
                    'Apply',
                    style: TextStyle(
                      color: AppColors.backgroundDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  labelPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  backgroundColor: AppColors.primaryColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
