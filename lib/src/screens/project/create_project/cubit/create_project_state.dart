part of 'create_project_cubit.dart';

class CreateProjectState extends Equatable {
  const CreateProjectState({
    this.title = const ProjectTitle.pure(),
    this.shortDescription = const ProjectBody.pure(),
    this.details = const ProjectBody.pure(),
    this.tagItems = const <TagName>[],
    this.status = FormzStatus.pure,
  });

  final ProjectTitle title;
  final ProjectBody shortDescription;
  final ProjectBody details;
  final List<TagName> tagItems;
  final FormzStatus status;

  CreateProjectState copyWith(
      {ProjectTitle? title,
      ProjectBody? shortDescription,
      ProjectBody? details,
      FormzStatus? status,
      List<TagName>? tagItems}) {
    return CreateProjectState(
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      details: details ?? this.details,
      status: status ?? this.status,
      tagItems: tagItems ?? this.tagItems,
    );
  }

  @override
  List<Object?> get props => [title, shortDescription, details, tagItems];
}
