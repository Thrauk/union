import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/sign_up/sign_up.dart';
import 'package:union_app/src/theme.dart';

class NameInputWidget extends StatelessWidget {
  const NameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.name != current.name,
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          onChanged: (String name) =>
              context.read<SignUpCubit>().nameChanged(name),
          cursorColor: AppColors.primaryColor,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid ? 'Invalid Name' : null,
          ),
        );
      },
    );
  }
}
