part of 'edit_organization_bloc.dart';

@immutable
abstract class EditOrganizationEvent {}

class LoadData extends EditOrganizationEvent {}

class NameChanged extends EditOrganizationEvent {
  NameChanged({required this.value});
  final String value;
}

class LocationChanged extends EditOrganizationEvent {
  LocationChanged({required this.value});
  final String value;
}

class DescriptionChanged extends EditOrganizationEvent {
  DescriptionChanged({required this.value});
  final String value;
}

class CategoryChanged extends EditOrganizationEvent {
  CategoryChanged({this.value});
  final String? value;
}

class TypeChanged extends EditOrganizationEvent {
  TypeChanged({required this.value});
  final bool value;
}

class ImageChanged extends EditOrganizationEvent {
  ImageChanged();
}

class UpdateOrganization extends EditOrganizationEvent {}