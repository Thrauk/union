import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:union_app/src/repository/storage/firebase_files_repository/firebase_files_repository.dart';

part 'upload_file_event.dart';

part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  UploadFileBloc(this._firebaseFilesRepository) : super(const UploadFileState()) {
    on<GetFileInitial>(_uploadFile);
    on<ChooseFilePressed>(_chooseFile);
    on<SaveFileToFirestore>(_saveFile);
  }

  final FirebaseFilesRepository _firebaseFilesRepository;
  FutureOr<void> _uploadFile(GetFileInitial event, Emitter<UploadFileState> emit) {}

  Future<FutureOr<void>> _chooseFile(ChooseFilePressed event, Emitter<UploadFileState> emit) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, withData: true);

    if (result != null) {
      emit(state.copyWith(file: result, status: StatusEnum.LOADING));
      add(SaveFileToFirestore(result, event.userId));
    }
  }

  Future<FutureOr<void>> _saveFile(SaveFileToFirestore event, Emitter<UploadFileState> emit) async {
    try{
      await _firebaseFilesRepository.saveFile(event.pickedFile, event.ownerId);
      emit(state.copyWith(status: StatusEnum.SUCCESSFUL));
    } catch (e) {
      emit(state.copyWith(status: StatusEnum.FAILED));
      print('_saveFile $e');
    }
  }
}
