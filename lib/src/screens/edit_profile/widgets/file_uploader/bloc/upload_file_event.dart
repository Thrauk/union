part of 'upload_file_bloc.dart';

abstract class UploadFileEvent {
  const UploadFileEvent();
}

class GetFileInitial extends UploadFileEvent {}
class ChooseFilePressed extends UploadFileEvent {}
