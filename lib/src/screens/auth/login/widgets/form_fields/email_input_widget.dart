import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login.dart';

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
          cursorColor: const Color.fromRGBO(169, 223, 216, 1),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'E-mail',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid E-mail' : null,
          ),
        );
      },
    );
  }
}
