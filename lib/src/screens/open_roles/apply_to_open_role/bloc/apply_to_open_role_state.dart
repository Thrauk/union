part of 'apply_to_open_role_bloc.dart';

@immutable
class ApplyToOpenRoleState extends Equatable {
  const ApplyToOpenRoleState(
      {this.status = FormzStatus.pure,
      this.cvAlreadyAdded = false,
      this.notice = '',
      this.cvUrl = '',
      this.id = '',
      this.filePickerResult});

  final FormzStatus status;
  final bool cvAlreadyAdded;
  final String notice;
  final String cvUrl;
  final String id;
  final FilePickerResult? filePickerResult;

  ApplyToOpenRoleState copyWith({
    FormzStatus? status,
    bool? cvAlreadyAdded,
    String? notice,
    String? id,
    String? cvUrl,
    FilePickerResult? filePickerResult,
  }) {
    return ApplyToOpenRoleState(
      status: status ?? this.status,
      notice: notice ?? this.notice,
      id: id ?? this.id,
      cvUrl: cvUrl ?? this.cvUrl,
      filePickerResult: filePickerResult ?? this.filePickerResult,
      cvAlreadyAdded: cvAlreadyAdded ?? this.cvAlreadyAdded,
    );
  }

  @override
  List<Object?> get props => [notice, filePickerResult, id, cvUrl, cvAlreadyAdded, status];
}
