part of 'user_projects_invites_bloc.dart';

enum PageStatus { INITIAL, LOADED, FAILED }

class UserProjectsInvitesState extends Equatable {
  const UserProjectsInvitesState(
      {this.invites = const <ProjectInviteItem>[],
      this.pageStatus = PageStatus.INITIAL});

  final List<ProjectInviteItem> invites;
  final PageStatus pageStatus;

  UserProjectsInvitesState copyWith(
      {List<ProjectInviteItem>? invites, List<FullUser>? senders, List<Project>? projects, PageStatus? pageStatus}) {
    return UserProjectsInvitesState(
        invites: invites ?? this.invites,
        pageStatus: pageStatus ?? this.pageStatus);
  }

  @override
  List<Object?> get props => <Object?>[invites, pageStatus];
}
