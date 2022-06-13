import 'package:formz/formz.dart';

import 'formz_generic_error.dart';
import 'formz_generic_validator.dart';

class FormzValidatorCollection {
  const FormzValidatorCollection({this.validators = const <String, FormzGenericValidator>{}});

  final Map<String, FormzGenericValidator> validators;

  // FormzValidatorCollection addValidator(String formKey, FormzGenericValidator validator) {
  //   if (!validators.containsKey(formKey)) {
  //     validators[formKey] = validator;
  //   } else {
  //     validators.update(formKey, (_) => validator);
  //   }
  //   return FormzValidatorCollection(
  //     validators: validators,
  //   );
  // }

  FormzValidatorCollection updateValidator(String formKey, FormzGenericValidator validator) {
    final Map<String, FormzGenericValidator> changedValidators = Map<String, FormzGenericValidator>.from(validators);
    if (validators.containsKey(formKey)) {
      changedValidators.update(formKey, (_) => validator);
    }
    return FormzValidatorCollection(
      validators: changedValidators,
    );
  }

  FormzValidatorCollection removeValidator(String formKey) {
    validators.remove(formKey);
    return FormzValidatorCollection(
      validators: validators,
    );
  }

  FormzStatus validateAll() {
    List<FormzInput<String, FormzGenericFieldError>> validatorsList;
    validatorsList = validators.entries.map((MapEntry<String, FormzGenericValidator> entry) {
      return entry.value;}).toList();
    return Formz.validate(validatorsList);
  }

  bool validateSingle(String formKey) {
    if(validators.containsKey(formKey)) {
      return validators[formKey]!.invalid;
    }
    return false;
  }


  FormzValidatorCollection copy() {
    return FormzValidatorCollection(validators: validators);
  }
}
