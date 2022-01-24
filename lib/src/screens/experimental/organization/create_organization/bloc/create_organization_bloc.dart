import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:union_app/src/screens/experimental/models/organization.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/data/data.dart';
import 'package:union_app/src/screens/experimental/repository/organization/firebase_organization_repository.dart';
import 'package:union_app/src/screens/experimental/utils/formz_validator/formz_long_text_validator.dart';
import 'package:union_app/src/screens/experimental/utils/formz_validator/formz_short_text_validator.dart';
import 'package:union_app/src/screens/experimental/utils/formz_validator/formz_validator_collection.dart';
import 'package:union_app/src/screens/experimental/utils/widgets/fields/single_line_generic_field.dart';

part 'create_organization_event.dart';

part 'create_organization_state.dart';

class CreateOrganizationBloc extends Bloc<CreateOrganizationEvent, CreateOrganizationState> {
  CreateOrganizationBloc({required String uid})
      : _uid = uid,
        super(const CreateOrganizationState()) {
    on<FieldChanged>(_onFieldChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<TypeChanged>(_onTypeChanged);
    on<LongFieldChanged>(_onLongFieldChanged);
    on<SelectImage>(_onSelectImage);
    on<ButtonPressed>(_onButtonPressed);
  }

  final FirebaseOrganizationRepository _firebaseOrganizationRepository = FirebaseOrganizationRepository();
  final String _uid;

  void _onFieldChanged(FieldChanged event, Emitter<CreateOrganizationState> emit) {
    final FormzValidatorCollection changedValidators =
        state.validators.updateValidator(event.fieldKey, ShortTextValidator.dirty(event.value));
    emit(state.copyWith(
      validators: changedValidators,
      status: changedValidators.validateAll(),
    ));
  }

  void _onLongFieldChanged(LongFieldChanged event, Emitter<CreateOrganizationState> emit) {
    final FormzValidatorCollection changedValidators =
        state.validators.updateValidator(event.fieldKey, LongTextValidator.dirty(event.value));
    emit(state.copyWith(
      validators: changedValidators,
      status: changedValidators.validateAll(),
    ));
  }

  void _onCategoryChanged(CategoryChanged event, Emitter<CreateOrganizationState> emit) {
    emit(state.copyWith(selectedCategory: event.category, categoryError: null));
  }

  void _onTypeChanged(TypeChanged event, Emitter<CreateOrganizationState> emit) {
    emit(state.copyWith(isPublic: event.isPublic));
  }

  Future<void> _onButtonPressed(ButtonPressed event, Emitter<CreateOrganizationState> emit) async {
    if (state.selectedCategory != null && state.status.isValid) {
      print('Valid to create');
      final Organization organization = Organization(
        name: state.validators.validators[FieldKeys.nameKey]!.value,
        ownerId: _uid,
        description: state.validators.validators[FieldKeys.descriptionKey]!.value,
        type: state.isPublic ? 'Public' : 'Private',
        category: state.selectedCategory!,
        location: state.validators.validators[FieldKeys.locationKey]!.value,
        photo: state.selectedImage,
        members: <String>[_uid],
      );
      await _firebaseOrganizationRepository.saveOrganization(organization);
      emit(state.copyWith(submissionSuccess: true));
    } else {
      if (state.selectedCategory == null) {
        emit(
          state.copyWith(
            categoryError: 'You must select a category first!',
            status: state.validators.validateAll(),
          ),
        );
      }
    }
  }

  Future<void> _onSelectImage(SelectImage event, Emitter<CreateOrganizationState> emit) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      emit(state.copyWith(selectedImage: File(selectedImage.path)));
    }
  }
}
