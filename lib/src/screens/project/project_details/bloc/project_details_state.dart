part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  const ProjectDetailsState(
      {this.openRoles = const <ProjectOpenRole>[],
      this.membersList = const <FullUser>[],
      this.githubRepositoryItem = GithubRepositoryItem.empty});

  final List<ProjectOpenRole> openRoles;
  final List<FullUser> membersList;
  final GithubRepositoryItem githubRepositoryItem;

  ProjectDetailsState copyWith(
      {List<ProjectOpenRole>? openRoles,
      List<FullUser>? membersList,
      List<Article>? articles,
      GithubRepositoryItem? githubRepositoryItem}) {
    return ProjectDetailsState(
      openRoles: openRoles ?? this.openRoles,
      membersList: membersList ?? this.membersList,
      githubRepositoryItem: githubRepositoryItem ?? this.githubRepositoryItem,
    );
  }

  @override
  List<Object?> get props => <Object?>[openRoles, membersList, githubRepositoryItem];
}
