import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/sign_up/cubit/sign_up_cubit.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
      previous.password != current.password,
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (String password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}