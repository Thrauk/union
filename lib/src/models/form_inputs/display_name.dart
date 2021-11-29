import 'package:formz/formz.dart';

enum DisplayNameValidationError { invalid }

class DisplayName extends FormzInput<String, DisplayNameValidationError> {
  const DisplayName.pure() : super.pure('');

  const DisplayName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'[a-zA-Z ]+',
  );

  @override
  DisplayNameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? value!.length < 20 ? null : DisplayNameValidationError.invalid
        : DisplayNameValidationError.invalid;
  }
}
