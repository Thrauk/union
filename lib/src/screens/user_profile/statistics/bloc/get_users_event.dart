part of 'get_users_bloc.dart';

abstract class GetUsersEvent {
  const GetUsersEvent();
}

class GetUsers extends GetUsersEvent {
  GetUsers(this.uids);

  final List<String> uids;
}
