import 'package:formz/formz.dart';

enum ProjectBodyValidationError { invalid }

class ProjectBody extends FormzInput<String, ProjectBodyValidationError> {
  const ProjectBody.pure() : super.pure('');

  const ProjectBody.dirty([String value = '']) : super.dirty(value);

  @override
  ProjectBodyValidationError? validator(String? value) {
    return (value!.length <= 300 && value.isNotEmpty) ? null : ProjectBodyValidationError.invalid;
  }
}
