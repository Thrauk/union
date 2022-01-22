import 'package:formz/formz.dart';
import 'package:union_app/src/screens/experimental/utils/formz_validator/formz_generic_error.dart';

import 'formz_generic_validator.dart';

class ShortTextValidator extends FormzGenericValidator {
  const ShortTextValidator.pure() : super.pure('');

  const ShortTextValidator.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z0-9]+$',
  );

  @override
  FormzGenericFieldError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? value!.length < 75 ? null : FormzGenericFieldError.invalid
        : FormzGenericFieldError.invalid;
  }
}
