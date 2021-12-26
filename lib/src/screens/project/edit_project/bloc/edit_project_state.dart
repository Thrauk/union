part of 'edit_project_bloc.dart';


class EditProjectState extends Equatable {
  const EditProjectState({
    this.project = const Project(),
    this.tag =  const TagName.pure(),
    this.status = FormzStatus.pure,
  });

  final Project project;
  final FormzStatus status;
  final TagName tag;

  EditProjectState copyWith({
    Project? project,
        FormzStatus? status,
        TagName? tag}) {
    return EditProjectState(
      project: project ?? this.project,
      status: status ?? this.status,
      tag: tag ?? this.tag,
    );
  }

  @override
  List<Object?> get props => [project, tag, status];
}

