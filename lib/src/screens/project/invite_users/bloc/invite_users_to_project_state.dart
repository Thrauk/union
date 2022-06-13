part of 'invite_users_to_project_bloc.dart';

enum PageStatus { INITIAL, FAILED, FINAL }

class InviteUsersToProjectState extends Equatable {
  const InviteUsersToProjectState(
      {this.pageStatus = PageStatus.INITIAL,
      this.query = '',
      this.resultedUsers = const <FullUser>[],
      this.invitedUsersUids = const <String>[]});

  final String query;
  final List<FullUser> resultedUsers;
  final PageStatus pageStatus;
  final List<String> invitedUsersUids;

  InviteUsersToProjectState copyWith(
      {String? query, List<FullUser>? resultedUsers, PageStatus? pageStatus, List<String>? invitedUsersUids}) {
    return InviteUsersToProjectState(
        query: query ?? this.query,
        resultedUsers: resultedUsers ?? this.resultedUsers,
        pageStatus: pageStatus ?? this.pageStatus,
        invitedUsersUids: invitedUsersUids ?? this.invitedUsersUids);
  }

  @override
  List<Object> get props => <Object>[query, resultedUsers, pageStatus, invitedUsersUids];
}
