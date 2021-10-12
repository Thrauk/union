import 'package:flutter/material.dart';

class ButtonsWidget02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(169, 223, 216, 1),
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
          side: BorderSide(
              width: 2.0, color: const Color.fromRGBO(169, 223, 216, 1)),
          minimumSize: Size(double.infinity, double.infinity)),
      child: Text(
        'Get started',
        style: TextStyle(
          color: Color.fromRGBO(18, 18, 18, 1),
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }

}