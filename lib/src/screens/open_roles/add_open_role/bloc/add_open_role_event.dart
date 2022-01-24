part of 'add_open_role_bloc.dart';

abstract class AddOpenRoleEvent {
  const AddOpenRoleEvent();
}

class TitleChanged extends AddOpenRoleEvent {
  TitleChanged(this.value);

  final String value;
}

class SpecificationsChanged extends AddOpenRoleEvent {
  SpecificationsChanged(this.value);

  final String value;
}

class CountryChanged extends AddOpenRoleEvent {
  CountryChanged(this.value);

  final String value;
}

class CityChanged extends AddOpenRoleEvent {
  CityChanged(this.value);

  final String value;
}

class ExperienceLevelChanged extends AddOpenRoleEvent {
  ExperienceLevelChanged(this.value);

  final String value;
}

class IsPaidChanged extends AddOpenRoleEvent {
  IsPaidChanged(this.value);

  final bool value;
}

class IsRemotePossibleChanged extends AddOpenRoleEvent {
  IsRemotePossibleChanged(this.value);

  final bool value;
}

class PostButtonPressed extends AddOpenRoleEvent {
  PostButtonPressed(this.projectId, this.ownerId);

  final String projectId;
  final String ownerId;
}
