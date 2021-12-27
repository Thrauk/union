import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/login/login.dart';
import 'package:union_app/src/theme.dart';


class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.email != current.email,
      builder: (BuildContext context, LoginState state) {
        return TextField(
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          onChanged: (String email) =>
              context.read<LoginCubit>().emailChanged(email),
          cursorColor: AppColors.primaryColor,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'E-mail',
            errorText: state.email.invalid ? 'Invalid E-mail' : null,
          ),
        );
      },
    );
  }
}
