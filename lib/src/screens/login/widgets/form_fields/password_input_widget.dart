import 'package:flutter/material.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      style: TextStyle(
        color: Color.fromRGBO(169, 223, 216, 1),
      ),
      cursorColor: Color.fromRGBO(169, 223, 216, 1),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        helperText: '',
        errorText: null,
      ),
    );
  }
}
