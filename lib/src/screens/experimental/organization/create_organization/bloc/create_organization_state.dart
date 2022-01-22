part of 'create_organization_bloc.dart';

class CreateOrganizationState extends Equatable {
  const CreateOrganizationState({
    this.validators = const FormzValidatorCollection(validators: initialValidators),
    this.status = FormzStatus.pure,
  });

  final FormzValidatorCollection validators;
  final FormzStatus status;

  CreateOrganizationState copyWith({
    FormzValidatorCollection? validators,
    FormzStatus? status,
  }) {
    return CreateOrganizationState(
      validators: validators ?? this.validators,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => <Object>[validators, status];
}
