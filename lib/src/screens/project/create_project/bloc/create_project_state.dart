part of 'create_project_bloc.dart';

class CreateProjectState extends Equatable {
  const CreateProjectState({
    this.title = const ProjectTitle.pure(),
    this.shortDescription = const ProjectBody.pure(),
    this.details = const ProjectBody.pure(),
    this.tag =  const TagName.pure(),
    this.tagItems = const <TagName>[],
    this.status = FormzStatus.pure,
  });

  final ProjectTitle title;
  final ProjectBody shortDescription;
  final ProjectBody details;
  final List<TagName> tagItems;
  final FormzStatus status;
  final TagName tag;

  CreateProjectState copyWith(
      {ProjectTitle? title,
      ProjectBody? shortDescription,
      ProjectBody? details,
      FormzStatus? status,
      List<TagName>? tagItems,
      TagName? tag}) {
    return CreateProjectState(
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      details: details ?? this.details,
      status: status ?? this.status,
      tag: tag ?? this.tag,
      tagItems: tagItems ?? this.tagItems,
    );
  }

  @override
  List<Object?> get props => [title, shortDescription, details, tagItems, tag];
}
