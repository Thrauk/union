part of 'apply_to_open_role_bloc.dart';

@immutable
abstract class ApplyToOpenRoleEvent {}

class NoticeChanged extends ApplyToOpenRoleEvent {
  NoticeChanged(this.value);

  final String value;
}

class ApplyButtonPressed extends ApplyToOpenRoleEvent {
  ApplyButtonPressed(this.uid, this.openRoleId);

  final String uid;
  final String openRoleId;
}

class ChooseFilePressed extends ApplyToOpenRoleEvent {
  ChooseFilePressed();
}

class VerifyIfUserHasCv extends ApplyToOpenRoleEvent {
  VerifyIfUserHasCv(this.uid);

  final String uid;
}
