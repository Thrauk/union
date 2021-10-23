import 'package:flutter/material.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return const TextField(
      style: TextStyle(
        color: Color.fromRGBO(169, 223, 216, 1),
      ),

      cursorColor: Color.fromRGBO(169, 223, 216, 1),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        helperText: '',
        errorText: null,
      ),
    );
  }
}
