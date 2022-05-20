part of 'create_project_bloc.dart';

class CreateProjectState extends Equatable {
  const CreateProjectState({
    this.title = const ProjectTitle.pure(),
    this.shortDescription = const ProjectBody.pure(),
    this.details = const ProjectBody.pure(),
    this.tag = const TagName.pure(),
    this.tagItems = const <TagName>[],
    this.status = FormzStatus.pure,
    this.githubRepository = GithubRepositoryItem.empty,
  });

  final ProjectTitle title;
  final ProjectBody shortDescription;
  final ProjectBody details;
  final List<TagName> tagItems;
  final FormzStatus status;
  final TagName tag;
  final GithubRepositoryItem githubRepository;

  CreateProjectState copyWith(
      {ProjectTitle? title,
      ProjectBody? shortDescription,
      ProjectBody? details,
      FormzStatus? status,
      List<TagName>? tagItems,
      GithubRepositoryItem? githubRepository,
      TagName? tag}) {
    return CreateProjectState(
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      details: details ?? this.details,
      status: status ?? this.status,
      tag: tag ?? this.tag,
      tagItems: tagItems ?? this.tagItems,
      githubRepository: githubRepository ?? this.githubRepository,
    );
  }

  @override
  List<Object?> get props => <Object?>[title, shortDescription, details, tagItems, tag, status, githubRepository];
}
