import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/theme.dart';

class FollowButtonsWidget extends StatelessWidget {
  const FollowButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (ProfileState previous, ProfileState current) => previous.followsUser != current.followsUser,
      builder: (BuildContext context, ProfileState state) {
        return TextButton(
          onPressed: () {
            context.read<ProfileBloc>().add(FollowOrUnfollow());
          },
          child: Text(
            state.followsUser ? 'Unfollow' : 'Follow',
            style: AppStyles.buttonTextStylePrimaryColor,
          ),
        );
      },
    );
  }
}
