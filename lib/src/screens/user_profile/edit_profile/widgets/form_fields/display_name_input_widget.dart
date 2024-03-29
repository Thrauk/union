import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../edit_profile.dart';

class DisplayNameInputWidget extends StatelessWidget {
  const DisplayNameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (EditProfileState previous, EditProfileState current) => previous.displayName != current.displayName,
      builder: (BuildContext context, EditProfileState state) {
        return TextFormField(
          initialValue: state.displayName.value,
          onChanged: (String value) => context.read<EditProfileBloc>().add(DisplayNameChanged(value: value)),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            labelText: 'Display name',
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
