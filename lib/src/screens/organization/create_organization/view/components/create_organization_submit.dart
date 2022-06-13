import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/theme.dart';

import '../../barrel.dart';


class CreateOrganizationSubmit extends StatelessWidget {
  const CreateOrganizationSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrganizationBloc, CreateOrganizationState>(
      builder: (BuildContext context, CreateOrganizationState state) {
        return SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<CreateOrganizationBloc>().add(ButtonPressed());
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.primaryColor,
              onSurface: Colors.transparent,
              shadowColor: Colors.transparent,
              side: const BorderSide(
                width: 2.0,
                color: AppColors.primaryColor,
              ),
              minimumSize: const Size(double.infinity, double.infinity),
            ),
            child: const Text(
              'Create organization',
              style: AppStyles.buttonTextStyle,
            ),
          ),
        );
      },
    );
  }
}
