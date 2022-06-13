import 'package:flutter/material.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class OrganizationTypeSwitch extends StatelessWidget {
  const OrganizationTypeSwitch({
    Key? key,
    required this.onChanged,
    required this.isPublic,
  }) : super(key: key);

  final void Function(bool) onChanged;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text(
              'Type: ',
              style: AppStyles.textStyleBody,
            ),
            SizedBox(width: 8,),
            SizedBox(
              width: 60,
              child: Text(
                isPublic ? 'Public' : 'Private',
                style: AppStyles.textStyleBodyPrimary,
              ),
            ),
            SimpleSwitch(
              value: isPublic,
              onChange: onChanged,
            ),
          ],
        ),
        Text(
          isPublic ? 'Public organizations are open to everyone.' : 'People must be added or request access in order to join a private organization. ',
          style: AppStyles.textStyleBodySmall,
        ),
      ],
    );
  }
}
