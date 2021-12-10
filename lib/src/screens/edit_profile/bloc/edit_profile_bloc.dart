import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_user_service/firebase_user_service.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({required FirebaseUserServiceRepository userServiceRepository,
    required String uid})
      : _userServiceRepository = userServiceRepository,
        _uid = uid,
        super(const EditProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<DisplayNameChanged>(_onDisplayNameChanged);
    on<JobTitleChanged>(_onJobTitleChanged);
    on<LocationChanged>(_onLocationChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<SelectImage>(_onSelectImage);
    on<UpdateProfile>(_onUpdateProfile);
    add(LoadProfile());
  }

  final FirebaseUserServiceRepository _userServiceRepository;
  final String _uid;

  Future<void> _onLoadProfile(LoadProfile event, Emitter<EditProfileState> emit) async {
    final FullUser fullUser = await _userServiceRepository.getFullUserByUid(_uid);
    emit(state.copyWith(
      fullUser: fullUser,
      displayName: DisplayName.dirty(fullUser.displayName ?? ''),
      jobTitle: ShortText.dirty(fullUser.jobTitle ?? ''),
      location: ShortText.dirty(fullUser.location ?? ''),
      description: LongText.dirty(fullUser.description ?? ''),
      profileLoaded: true,
      photoUrl: fullUser.photo,
    ));
  }

  void _onDisplayNameChanged(DisplayNameChanged event, Emitter<EditProfileState> emit) {
    final DisplayName displayName = DisplayName.dirty(event.value);
    emit(state.copyWith(
      displayName: displayName,
      status: Formz.validate([displayName, state.jobTitle, state.location, state.description]),
    ));
  }

  void _onJobTitleChanged(JobTitleChanged event, Emitter<EditProfileState> emit) {
    final ShortText jobTitle = ShortText.dirty(event.value);
    emit(state.copyWith(
      jobTitle: jobTitle,
      status: Formz.validate([state.displayName, jobTitle, state.location, state.description]),
    ));
  }

  void _onLocationChanged(LocationChanged event, Emitter<EditProfileState> emit)  {
    final ShortText location = ShortText.dirty(event.value);
    emit(state.copyWith(
      location: location,
      status: Formz.validate([state.displayName, state.jobTitle, location, state.description]),
    ));
  }

  void _onDescriptionChanged(DescriptionChanged event, Emitter<EditProfileState> emit) {
    final LongText description = LongText.dirty(event.value);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([state.displayName, state.jobTitle, state.location, description]),
    ));
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<EditProfileState> emit) async {
    if(state.status.isValidated) {
      try {
        await _userServiceRepository.updateUserDetails(state.fullUser.copyWith(
          displayName: state.displayName.value,
          jobTitle: state.jobTitle.value,
          location: state.location.value,
          description: state.description.value,
        ));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch(_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }

    }
  }

  Future<void> _onSelectImage(SelectImage event, Emitter<EditProfileState> emit) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if(selectedImage != null) {
      String url = await _userServiceRepository.updateUserImage(state.fullUser, File(selectedImage.path));
      emit(state.copyWith(photoUrl: url));
    }
  }


  @override
  Future<void> close() {
    return super.close();
  }

}
