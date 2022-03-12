part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  const ProjectDetailsState(
      {this.openRoles = const <ProjectOpenRole>[], this.membersList = const <FullUser>[], this.articles = const <Article>[]});

  final List<ProjectOpenRole> openRoles;
  final List<FullUser> membersList;
  final List<Article> articles;

  ProjectDetailsState copyWith({List<ProjectOpenRole>? openRoles, List<FullUser>? membersList, List<Article>? articles}) {
    return ProjectDetailsState(
        openRoles: openRoles ?? this.openRoles,
        membersList: membersList ?? this.membersList,
        articles: articles ?? this.articles);
  }

  @override
  List<Object?> get props => [openRoles, membersList, articles];
}
