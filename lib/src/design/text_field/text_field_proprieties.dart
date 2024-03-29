import 'package:flutter/material.dart';

class TextFieldProprieties {
  String name = '';

  static InputDecoration revolutishInputDecoration(
      {String labelText = '', String hintText = '', String? errorText}) {
    return InputDecoration(
      border: InputBorder.none,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      fillColor: const Color.fromRGBO(50, 50, 50, 0.7),
      filled: true,
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
    );
  }
}
