import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/widgets/fields/fields.dart';

class OrganizationEditForm extends StatelessWidget {
  const OrganizationEditForm({
    Key? key,
    required this.organization,
    this.onNameChanged,
    this.onLocationChanged,
    this.onDescriptionChanged,
    this.nameError = false,
    this.locationError = false,
    this.descriptionError = false,
  }) : super(key: key);

  final Organization organization;
  final void Function(String)? onNameChanged;
  final void Function(String)? onLocationChanged;
  final void Function(String)? onDescriptionChanged;
  final bool nameError;
  final bool locationError;
  final bool descriptionError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleLineField(
          labelText: 'Name',
          initialText: organization.name,
          onChanged: onNameChanged,
          errorText: nameError ? 'Invalid name' : null,
        ),
        const SizedBox(height: 15),
        SingleLineField(
          labelText: 'Location',
          initialText: organization.location,
          onChanged: onLocationChanged,
          errorText: locationError ? 'Invalid location' : null,
        ),
        const SizedBox(height: 15),
        MultiLineField(
          labelText: 'Description',
          initialText: organization.description,
          onChanged: onDescriptionChanged,
          errorText: descriptionError ? 'Invalid description' : null,
        ),
      ],
    );
  }
}
