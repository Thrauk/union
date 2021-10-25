import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
  primaryColorLight: const Color.fromRGBO(215, 223, 113, 1),
  primaryColor: const Color.fromRGBO(169, 223, 216, 1),
  colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  fontFamily: 'Lato',
);
