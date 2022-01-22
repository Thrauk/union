part of 'upload_file_bloc.dart';

enum StatusEnum { INITIAL, LOADING, SUCCESSFUL, FAILED }

class UploadFileState extends Equatable {
  const UploadFileState({this.file, this.status = StatusEnum.INITIAL});

  final FilePickerResult? file;
  final StatusEnum status;

  UploadFileState copyWith({
    FilePickerResult? file,
    StatusEnum? status
  }) {
    return UploadFileState(
      file: file ?? this.file,
        status: status ?? this.status
    );
  }

  @override
  List<Object?> get props => [status, file];
}
