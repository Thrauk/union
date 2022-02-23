import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../edit_profile.dart';

class LocationInputWidget extends StatelessWidget {
  const LocationInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        buildWhen: (EditProfileState previous, EditProfileState current) =>
            previous.location != current.location,
        builder: (BuildContext context, EditProfileState state) {
          return TextFormField(
            initialValue: state.location.value,
            onChanged: (String value) => context
                .read<EditProfileBloc>()
                .add(LocationChanged(value: value)),
            cursorColor: Colors.white,
            // decoration: TextFieldProprieties.revolutishInputDecoration(
            //   labelText: 'Location',
            //   hintText: 'Location',
            // ),
            decoration: const InputDecoration(
              labelText: 'Location',
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
          );
        });
  }
}
