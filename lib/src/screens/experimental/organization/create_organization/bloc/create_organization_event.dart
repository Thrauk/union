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
