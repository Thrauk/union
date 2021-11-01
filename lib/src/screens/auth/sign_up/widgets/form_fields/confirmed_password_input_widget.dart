import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/sign_up/sign_up.dart';

class ConfirmPasswordInputWidget extends StatelessWidget {
  const ConfirmPasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          onChanged: (String confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          cursorColor: const Color.fromRGBO(169, 223, 216, 1),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'Passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}
