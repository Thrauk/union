import 'package:flutter/material.dart';




final ThemeData theme = ThemeData(
  hintColor: Color.fromRGBO(255, 255, 255, 0.7),
  primaryColorDark: const Color.fromRGBO(18, 18, 18, 1),
  primaryColorLight: const Color.fromRGBO(215, 223, 113, 1),
  primaryColor: const Color.fromRGBO(169, 223, 216, 1),

  colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
  scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(
      color: Color.fromRGBO(169, 223, 216, 1),
    ),
    hintStyle: const TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.7)
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(169, 223, 216, 1),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(255, 255, 255, 0.7),
      ),
    ),
  ),
);
