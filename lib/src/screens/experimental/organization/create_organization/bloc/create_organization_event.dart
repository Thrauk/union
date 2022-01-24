part of 'create_organization_bloc.dart';

abstract class CreateOrganizationEvent extends Equatable {
  const CreateOrganizationEvent();

  @override
  List<Object> get props => <Object>[];
}

class FieldChanged extends CreateOrganizationEvent {
  const FieldChanged({
    required this.fieldKey,
    required this.value,
  });

  final String fieldKey;
  final String value;
}

class LongFieldChanged extends CreateOrganizationEvent {
  const LongFieldChanged({
    required this.fieldKey,
    required this.value,
  });

  final String fieldKey;
  final String value;
}

class CategoryChanged extends CreateOrganizationEvent {
  const CategoryChanged({this.category});

  final String? category;
}

class TypeChanged extends CreateOrganizationEvent {
  const TypeChanged({required this.isPublic});

  final bool isPublic;
}

class SelectImage extends CreateOrganizationEvent {
}

class ButtonPressed extends CreateOrganizationEvent {
}
