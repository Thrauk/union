part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadProfile extends EditProfileEvent{}

class DisplayNameChanged extends EditProfileEvent {
  const DisplayNameChanged({required this.value});

  final String value;

  @override
  List<Object> get props => <Object>[value];
}

class JobTitleChanged extends EditProfileEvent {
  const JobTitleChanged({required this.value});

  final String value;

  @override
  List<Object> get props => <Object>[value];
}

class LocationChanged extends EditProfileEvent {
  const LocationChanged({required this.value});

  final String value;

  @override
  List<Object> get props => <Object>[value];
}

class DescriptionChanged extends EditProfileEvent {
  const DescriptionChanged({required this.value});

  final String value;

  @override
  List<Object> get props => <Object>[value];
}

class UpdateProfile extends EditProfileEvent {}

class UpdateProfileSuccess extends EditProfileEvent {}
