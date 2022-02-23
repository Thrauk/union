import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/theme.dart';

import '../../barrel.dart';


class CreateOrganizationChoices extends StatelessWidget {
  const CreateOrganizationChoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrganizationBloc, CreateOrganizationState>(
      builder: (BuildContext context, CreateOrganizationState state) {
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                hint: const Text(
                  'Organization category',
                  style: AppStyles.textStyleBodyPrimary,
                ),
                value: state.selectedCategory,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primaryColor,
                ),
                elevation: 16,
                style: AppStyles.textStyleBodyPrimary,
                underline: Container(
                  height: 2,
                  color: state.categoryError == null ? AppColors.primaryColor : Colors.red,
                ),
                onChanged: (String? selectedCategory) {
                  context.read<CreateOrganizationBloc>().add(CategoryChanged(category: selectedCategory));
                },
                items: organizationCategories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            if (state.categoryError != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.categoryError!,
                  style: AppStyles.textStyleBodySmallError,
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const Text(
                  'Type: ',
                  style: AppStyles.textStyleBody,
                ),
                SizedBox(width: 60, child: Text(state.isPublic ? 'Public' : 'Private', style: AppStyles.textStyleBodyPrimary)),
                Switch(
                  value: state.isPublic,
                  onChanged: (bool value) {
                    context.read<CreateOrganizationBloc>().add(TypeChanged(isPublic: value));
                  },
                  activeColor: AppColors.primaryColor,
                ),
              ],
            ),
            const Text(
              'People must be added or request access in order to join a private organization. ' +
                  'Public organizations are open to everyone.',
              style: AppStyles.textStyleBodySmall,
            ),
          ],
        );
      },
    );
  }
}
