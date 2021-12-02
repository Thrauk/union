import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/design/design.dart';
import 'package:union_app/src/screens/edit_profile/edit_profile.dart';

class DescriptionInputWidget extends StatelessWidget {
  const DescriptionInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        buildWhen: (EditProfileState previous, EditProfileState current) =>
            previous.description != current.description,
        builder: (BuildContext context, EditProfileState state) {
          return TextFormField(
            initialValue: state.description.value,
            onChanged: (String value) => context
                .read<EditProfileBloc>()
                .add(DescriptionChanged(value: value)),
            cursorColor: Colors.white,
            decoration: TextFieldProprieties.revolutishInputDecoration(
              labelText: 'Description',
              hintText: 'Description',
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
          );
        });
  }
}
