import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/theme.dart';

import '../profile.dart';

class ProfileDescriptionWidget extends StatelessWidget {
  const ProfileDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (ProfileState previous, ProfileState current) {
      return previous.fullUser.description != current.fullUser.description;
    }, builder: (BuildContext context, ProfileState state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            // color: AppColors.backgroundLight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Bio',
                  style: AppStyles.textStyleHeading1,
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '${state.fullUser.description}',
                    textAlign: TextAlign.start,
                    style: AppStyles.textStyleBody,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
