part of 'invite_users_to_project_bloc.dart';

enum PageStatus { INITIAL, FAILED, FINAL }

class InviteUsersToProjectState extends Equatable {
  const InviteUsersToProjectState(
      {this.pageStatus = PageStatus.INITIAL,
      this.query = '',
      this.resultedUsers = const <FullUser>[],
      this.invites = const <ProjectInvite>[]});

  final String query;
  final List<FullUser> resultedUsers;
  final PageStatus pageStatus;
  final List<ProjectInvite> invites;

  InviteUsersToProjectState copyWith({String? query, List<FullUser>? resultedUsers, PageStatus? pageStatus}) {
    return InviteUsersToProjectState(
        query: query ?? this.query,
        resultedUsers: resultedUsers ?? this.resultedUsers,
        pageStatus: pageStatus ?? this.pageStatus);
  }

  @override
  List<Object> get props => <Object>[query, resultedUsers];
}
