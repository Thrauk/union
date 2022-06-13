import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'upload_file_event.dart';

part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  UploadFileBloc(this._firebaseFilesRepository) : super(const UploadFileState()) {
    on<GetFileInitial>(_getFileInitial);
    on<ChooseFilePressed>(_chooseFile);
    on<SaveFileToFirestore>(_saveFile);
    on<RemoveFilePressed>(_removeFile);
  }

  final FirebaseFilesRepository _firebaseFilesRepository;

  Future<FutureOr<void>> _getFileInitial(GetFileInitial event, Emitter<UploadFileState> emit) async {
    final bool isAdded = await _firebaseFilesRepository.isCVFileAlreadyAddedAtUser(event.userId);
    print("isAdded $isAdded");
    emit(state.copyWith(isFileAlreadyAdded: isAdded));
  }

  Future<FutureOr<void>> _chooseFile(ChooseFilePressed event, Emitter<UploadFileState> emit) async {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowMultiple: false, withData: true, allowedExtensions: ['pdf']);

    if (result != null) {
      emit(state.copyWith(file: result, status: StatusEnum.LOADING));
      add(SaveFileToFirestore(result, event.userId));
    }
  }

  Future<FutureOr<void>> _saveFile(SaveFileToFirestore event, Emitter<UploadFileState> emit) async {
    try {
      await _firebaseFilesRepository.saveCVFileToUser(event.pickedFile, event.ownerId);
      emit(state.copyWith(status: StatusEnum.SUCCESSFUL, isFileAlreadyAdded: true));
    } catch (e) {
      emit(state.copyWith(status: StatusEnum.FAILED));
      print('_saveFile $e');
    }
  }

  Future<FutureOr<void>> _removeFile(RemoveFilePressed event, Emitter<UploadFileState> emit) async {
    try {
      await _firebaseFilesRepository.deleteCVFileFromUser(event.userId);
      emit(state.copyWith(status: StatusEnum.INITIAL, isFileAlreadyAdded: false));
    } catch (e) {
      emit(state.copyWith(status: StatusEnum.FAILED));
      print('_removeFile $e');
    }
  }
}
