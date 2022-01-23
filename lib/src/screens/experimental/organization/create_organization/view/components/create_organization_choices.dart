import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/data/data.dart';

import '../../../../../../theme.dart';

class CreateOrganizationChoices extends StatelessWidget {
  const CreateOrganizationChoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: DropdownButton<String>(
            hint: const Text(
              'Organization category',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            //value: dropdownValue,
            icon: const Icon(
              Icons.arrow_downward,
              color: AppColors.primaryColor,
            ),
            elevation: 16,
            style: const TextStyle(color: AppColors.primaryColor),
            underline: Container(
              height: 2,
              color: AppColors.primaryColor,
            ),
            onChanged: (String? newValue) {
              // setState(() {
              //   dropdownValue = newValue!;
              // });
            },
            items: organizationCategories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        Row(
          children: <Widget>[
            Text(
              'Type: ',
              style: AppStyles.textStyleBody,
            ),
            Text('Public/Private', style: AppStyles.textStyleBodyPrimary),
            CupertinoSwitch(
              value: true,
              onChanged: (bool value) {},
              activeColor: AppColors.primaryColor,
            ),
          ],
        ),
        Text(
          'People must be added or request access in order to join a private organization. ' +
              'Public organizations are open to everyone.',
          style: AppStyles.textStyleBodySmall,),
      ],
    );
  }
}
