import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/login/login.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          (previous.password != current.password) ||
          (previous.hidePassword != current.hidePassword),
      builder: (BuildContext context, LoginState state) {
        return TextField(
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          onChanged: (String password) =>
              context.read<LoginCubit>().passwordChanged(password),
          cursorColor: const Color.fromRGBO(169, 223, 216, 1),
          obscureText: state.hidePassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.remove_red_eye_sharp,
                color: Color.fromRGBO(255, 255, 255, 0.8),
              ),
              onPressed: () {
                context.read<LoginCubit>().hidePasswordChanged();
              },
            ),
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}
