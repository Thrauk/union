part of 'upload_file_bloc.dart';

abstract class UploadFileState extends Equatable {
  const UploadFileState();
}

class UploadFileInitial extends UploadFileState {
  @override
  List<Object> get props => [];
}
