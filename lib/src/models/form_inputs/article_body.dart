import 'package:formz/formz.dart';

enum ArticleBodyValidationError { invalid }

class ArticleBody extends FormzInput<String, ArticleBodyValidationError> {
  const ArticleBody.pure() : super.pure('');

  const ArticleBody.dirty([String value = '']) : super.dirty(value);

  @override
  ArticleBodyValidationError? validator(String? value) {
    return (value != null && value.isNotEmpty)
        ? null
        : ArticleBodyValidationError.invalid;
  }
}
