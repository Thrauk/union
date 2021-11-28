import 'package:formz/formz.dart';

enum TagNameValidationError { invalid }

class TagName extends FormzInput<String, TagNameValidationError> {
  const TagName.pure() : super.pure('');

  TagName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'[a-zA-Z0-9]+',
  );

  // List<TagName>? list = [];

  TagNameValidationError? isInList(List<TagName> list) {
    if (list.contains(this)) {
      return TagNameValidationError.invalid;
    }
    return null;
  }

  @override
  TagNameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? (value!.length < 20 ? null : TagNameValidationError.invalid)
        : TagNameValidationError.invalid;
    // if (_nameRegExp.hasMatch(value ?? '')) {
    //   if (value!.length < 20) {
    //     if (list.isNotEmpty) {
    //       return list.contains(TagName.dirty(value))
    //           ? TagNameValidationError.invalid
    //           : null;
    //     }
    //   }
    // }
  }
}
