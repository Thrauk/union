import 'package:formz/formz.dart';

enum ProjectTitleValidationError { invalid }

class ProjectTitle extends FormzInput<String, ProjectTitleValidationError> {
  const ProjectTitle.pure() : super.pure('');

  const ProjectTitle.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'[a-zA-Z0-9]+',
  );

  @override
  ProjectTitleValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? value!.length < 75 ? null : ProjectTitleValidationError.invalid
        : ProjectTitleValidationError.invalid;
  }
}
