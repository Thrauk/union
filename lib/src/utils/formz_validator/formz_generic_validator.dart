import 'package:formz/formz.dart';
import 'formz_generic_error.dart';

abstract class FormzGenericValidator extends FormzInput<String, FormzGenericFieldError> {
  const FormzGenericValidator.pure(String value) : super.pure(value);
  const FormzGenericValidator.dirty(String value) : super.dirty(value);
}
