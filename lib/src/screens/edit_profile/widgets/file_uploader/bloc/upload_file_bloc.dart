import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_file_event.dart';
part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  UploadFileBloc() : super(UploadFileInitial()) {
    on<GetFileInitial>(_uploadFile);
    on<ChooseFilePressed>(_chooseFile);
  }

  FutureOr<void> _uploadFile(GetFileInitial event, Emitter<UploadFileState> emit) {
  }

  FutureOr<void> _chooseFile(ChooseFilePressed event, Emitter<UploadFileState> emit) {
  }
}
