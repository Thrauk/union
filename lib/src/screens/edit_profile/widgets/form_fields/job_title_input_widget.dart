import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/design/design.dart';
import 'package:union_app/src/screens/edit_profile/edit_profile.dart';

class JobTitleInputWidget extends StatelessWidget {
  const JobTitleInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        buildWhen: (EditProfileState previous, EditProfileState current) =>
            previous.jobTitle != current.jobTitle,
        builder: (BuildContext context, EditProfileState state) {
          return TextFormField(
            initialValue: state.jobTitle.value,
            onChanged: (String value) => context
                .read<EditProfileBloc>()
                .add(JobTitleChanged(value: value)),
            cursorColor: Colors.white,
            decoration: TextFieldProprieties.revolutishInputDecoration(
              labelText: 'Job title',
              hintText: 'Job title',
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
          );
        });
  }
}
