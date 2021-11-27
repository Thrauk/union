import 'package:formz/formz.dart';

enum TagNameValidationError { invalid }

class TagName extends FormzInput<String, TagNameValidationError> {
  const TagName.pure() : super.pure('');

  const TagName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'[a-zA-Z0-9]+',
  );

  @override
  TagNameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? value!.length < 20 ? null : TagNameValidationError.invalid
        : TagNameValidationError.invalid;
  }
}
