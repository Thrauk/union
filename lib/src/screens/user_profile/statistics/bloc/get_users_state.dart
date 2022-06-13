part of 'get_users_bloc.dart';

enum PageStatus { LOADING, SUCCESSFUL, FAILED }

class GetUsersState extends Equatable {
  const GetUsersState({this.pageStatus = PageStatus.LOADING, this.users = const <FullUser>[]});

  final List<FullUser> users;
  final PageStatus pageStatus;

  GetUsersState copyWith({List<FullUser>? users, PageStatus? pageStatus}) {
    return GetUsersState(pageStatus: pageStatus ?? this.pageStatus, users: users ?? this.users);
  }

  @override
  List<Object?> get props => <Object?>[users, pageStatus];
}
