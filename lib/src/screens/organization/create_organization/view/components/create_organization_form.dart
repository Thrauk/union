import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/widgets/widgets.dart';

import '../../barrel.dart';

class CreateOrganizationForm extends StatelessWidget {
  const CreateOrganizationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrganizationBloc, CreateOrganizationState>(
      builder: (BuildContext context, CreateOrganizationState state) {
        return Column(
          children: <Widget>[
            SingleLineGenericField(
                key: const Key(FieldKeys.nameKey),
                errorText: state.validators.validateSingle(FieldKeys.nameKey) ? 'Invalid name' : null,
                labelText: 'Name',
                onChanged: (String value) {
                  context.read<CreateOrganizationBloc>().add(FieldChanged(fieldKey: FieldKeys.nameKey, value: value));
                }),
            const SizedBox(
              height: 15,
            ),
            SingleLineGenericField(
                key: const Key(FieldKeys.locationKey),
                errorText: state.validators.validateSingle(FieldKeys.locationKey) ? 'Invalid location' : null,
                labelText: 'Location',
                onChanged: (String value) {
                  context.read<CreateOrganizationBloc>().add(FieldChanged(fieldKey: FieldKeys.locationKey, value: value));
                }),
            const SizedBox(
              height: 15,
            ),
            MultiLineGenericField(
              key: const Key(FieldKeys.descriptionKey),
              labelText: 'Description',
              errorText: state.validators.validateSingle(FieldKeys.descriptionKey) ? 'Invalid description' : null,
              onChanged: (String value) {
                context.read<CreateOrganizationBloc>().add(LongFieldChanged(fieldKey: FieldKeys.descriptionKey, value: value));
              },
            ),
          ],
        );
      },
    );
  }
}
