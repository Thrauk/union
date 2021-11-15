import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/sign_up/sign_up.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          (previous.password != current.password) ||
          (previous.hidePassword != current.hidePassword),
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          onChanged: (String password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          cursorColor: const Color.fromRGBO(169, 223, 216, 1),
          obscureText: state.hidePassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.remove_red_eye_sharp,
                color: Color.fromRGBO(255, 255, 255, 0.8),
              ),
              onPressed: () {
                context.read<SignUpCubit>().hidePasswordChanged();
              },
            ),
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}
