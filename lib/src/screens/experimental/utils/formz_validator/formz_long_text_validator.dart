import 'package:formz/formz.dart';
import 'package:union_app/src/screens/experimental/utils/formz_validator/formz_generic_error.dart';

import 'formz_generic_validator.dart';

class LongTextValidator extends FormzGenericValidator {
  const LongTextValidator.pure() : super.pure('');

  const LongTextValidator.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z0-9 @?.]+$',
  );

  @override
  FormzGenericFieldError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? value!.length < 2048 ? null : FormzGenericFieldError.invalid
        : FormzGenericFieldError.invalid;
  }
}
