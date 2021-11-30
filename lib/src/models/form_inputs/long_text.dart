import 'package:formz/formz.dart';

enum LongTextValidationError { invalid }

class LongText extends FormzInput<String, LongTextValidationError> {
  const LongText.pure() : super.pure('');

  const LongText.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'[a-zA-Z ]+',
  );

  @override
  LongTextValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? value!.length < 255 ? null : LongTextValidationError.invalid
        : LongTextValidationError.invalid;
  }
}
