import 'package:formz/formz.dart';

enum ShortTextValidationError { invalid }

class ShortText extends FormzInput<String, ShortTextValidationError> {
  const ShortText.pure() : super.pure('');

  const ShortText.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'[a-zA-Z ]+',
  );

  @override
  ShortTextValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? value!.length < 20 ? null : ShortTextValidationError.invalid
        : ShortTextValidationError.invalid;
  }
}
