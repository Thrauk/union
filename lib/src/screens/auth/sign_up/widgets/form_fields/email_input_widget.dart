import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/sign_up/sign_up.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.email != current.email,
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          onChanged: (String email) =>
              context.read<SignUpCubit>().emailChanged(email),
          cursorColor: const Color.fromRGBO(169, 223, 216, 1),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid E-mail' : null,
          ),
        );
      },
    );
  }
}
