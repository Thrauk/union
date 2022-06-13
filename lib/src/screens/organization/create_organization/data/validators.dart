part of 'data.dart';

const Map<String, FormzGenericValidator> initialValidators = <String, FormzGenericValidator>{
  FieldKeys.nameKey : ShortTextValidator.pure(),
  FieldKeys.descriptionKey : LongTextValidator.pure(),
  FieldKeys.locationKey : ShortTextValidator.pure(),
};
