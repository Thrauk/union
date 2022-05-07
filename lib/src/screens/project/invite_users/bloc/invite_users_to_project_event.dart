part of 'invite_users_to_project_bloc.dart';

abstract class InviteUsersToProjectEvent {
  const InviteUsersToProjectEvent();
}

class SearchIconPressed extends InviteUsersToProjectEvent {}

class InvitePressed extends InviteUsersToProjectEvent {
  InvitePressed(this.uid);

  String uid;
}

class TextChanged extends InviteUsersToProjectEvent {
  TextChanged(this.value);

  String value;
}
