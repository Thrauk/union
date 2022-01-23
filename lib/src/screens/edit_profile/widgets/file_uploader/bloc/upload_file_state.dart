part of 'upload_file_bloc.dart';

enum StatusEnum { INITIAL, LOADING, SUCCESSFUL, FAILED }

class UploadFileState extends Equatable {
  const UploadFileState({this.file, this.status = StatusEnum.INITIAL, this.isFileAlreadyAdded = false});

  final FilePickerResult? file;
  final StatusEnum status;
  final bool isFileAlreadyAdded;

  UploadFileState copyWith({
    FilePickerResult? file,
    StatusEnum? status,
    bool? isFileAlreadyAdded,
  }) {
    return UploadFileState(
        file: file ?? this.file,
        status: status ?? this.status,
        isFileAlreadyAdded: isFileAlreadyAdded ?? this.isFileAlreadyAdded);
  }

  @override
  List<Object?> get props => [status, file, isFileAlreadyAdded];
}
