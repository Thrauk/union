part of 'upload_file_bloc.dart';

abstract class UploadFileEvent {
  const UploadFileEvent();
}

class GetFileInitial extends UploadFileEvent {
  GetFileInitial(this.userId);

  final String userId;
}
class ChooseFilePressed extends UploadFileEvent {
  ChooseFilePressed(this.userId);

  final String userId;
}
class SaveFileToFirestore extends UploadFileEvent {
  SaveFileToFirestore(this.pickedFile, this.ownerId);

  final FilePickerResult pickedFile;
  final String ownerId;
}
