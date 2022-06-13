import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/organization/firebase_organization_repository.dart';
import 'package:union_app/src/utils/utils.dart';

part 'edit_organization_event.dart';

part 'edit_organization_state.dart';

class EditOrganizationBloc extends Bloc<EditOrganizationEvent, EditOrganizationState> {
  EditOrganizationBloc({required this.organizationId}) : super(const EditOrganizationState()) {
    on<LoadData>(_onLoadData);
    on<ImageChanged>(_onImageChanged);
    on<NameChanged>(_onNameChanged);
    on<LocationChanged>(_onLocationChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<TypeChanged>(_onTypeChanged);
    on<UpdateOrganization>(_onUpdateOrganization);
  }

  final String organizationId;
  final FirebaseOrganizationRepository _organizationRepository = FirebaseOrganizationRepository();

  Future<void> _onLoadData(LoadData event, Emitter<EditOrganizationState> emit) async {
    print('LoadData');
    final Organization organization = await _organizationRepository.getOrganizationById(organizationId);
    final ShortTextValidator name = ShortTextValidator.dirty(organization.name);
    final ShortTextValidator location = ShortTextValidator.dirty(organization.location);
    final LongTextValidator description = LongTextValidator.dirty(organization.description);
    emit(state.copyWith(
      organization: organization,
      name: name,
      location: location,
      description: description,
      isPublic: organization.type == 'Public',
      selectedCategory: organization.category,
      isLoading: false,
      status: Formz.validate([name, location, description]),
    ));
  }

  Future<void> _onImageChanged(ImageChanged event, Emitter<EditOrganizationState> emit) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      emit(
        state.copyWith(
          selectedImage: File(selectedImage.path),
        ),
      );
    }
  }

  Future<void> _onNameChanged(NameChanged event, Emitter<EditOrganizationState> emit) async {
    final ShortTextValidator name = ShortTextValidator.dirty(event.value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.location, state.description]),
    ));
  }

  Future<void> _onLocationChanged(LocationChanged event, Emitter<EditOrganizationState> emit) async {
    final ShortTextValidator location = ShortTextValidator.dirty(event.value);
    emit(state.copyWith(
      location: location,
      status: Formz.validate([state.name, location, state.description]),
    ));
  }

  Future<void> _onDescriptionChanged(DescriptionChanged event, Emitter<EditOrganizationState> emit) async {
    final LongTextValidator description = LongTextValidator.dirty(event.value);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([state.name, state.location, description]),
    ));
  }

  Future<void> _onCategoryChanged(CategoryChanged event, Emitter<EditOrganizationState> emit) async {
    emit(state.copyWith(
      selectedCategory: event.value,
    ));
  }

  Future<void> _onTypeChanged(TypeChanged event, Emitter<EditOrganizationState> emit) async {
    emit(state.copyWith(
      isPublic: event.value,
    ));
  }

  Future<void> _onUpdateOrganization(UpdateOrganization event, Emitter<EditOrganizationState> emit) async {
    if(state.status.isValid) {
      final Organization updatedOrganization = state.organization.copyWith(
        name: state.name.value,
        location: state.location.value,
        description: state.description.value,
        photo: state.selectedImage,
        category: state.selectedCategory,
        type: state.isPublic ? 'Public' : 'Private',
      );
      await _organizationRepository.updateOrganization(organizationId, updatedOrganization);
      emit(state.copyWith(submissionSuccess: true));
    }

  }
}
