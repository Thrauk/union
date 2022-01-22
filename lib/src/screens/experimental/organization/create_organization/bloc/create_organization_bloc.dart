import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/data/data.dart';
import 'package:union_app/src/screens/experimental/utils/formz_validator/formz_short_text_validator.dart';
import 'package:union_app/src/screens/experimental/utils/formz_validator/formz_validator_collection.dart';
import 'package:union_app/src/screens/experimental/utils/widgets/fields/single_line_generic_field.dart';

part 'create_organization_event.dart';

part 'create_organization_state.dart';

class CreateOrganizationBloc extends Bloc<CreateOrganizationEvent, CreateOrganizationState> {
  CreateOrganizationBloc() : super(const CreateOrganizationState()) {
    on<FieldChanged>(_onFieldChanged);
  }

  void _onFieldChanged(FieldChanged event, Emitter<CreateOrganizationState> emit) {
    final FormzValidatorCollection changedValidators =
        state.validators.updateValidator(event.fieldKey, ShortTextValidator.dirty(event.value));
    emit(state.copyWith(
      validators: changedValidators,
      status: changedValidators.validateAll(),
    ));
  }
}
