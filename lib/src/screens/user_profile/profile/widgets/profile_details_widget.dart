import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/messaging/chat/view/chat_page.dart';
import 'package:union_app/src/screens/user_profile/edit_profile/edit_profile.dart';

import 'package:union_app/src/theme.dart';

import '../profile.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Avatar(
                  photo: state.fullUser.photo,/////////////////
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  state.fullUser.displayName ?? 'John Doe',
                  style: AppStyles.textStyleHeadingWhite20,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      state.fullUser.location ?? 'No location',
                      style: AppStyles.textStyleBody
                    ),
                    const Text(
                      ' • ',
                      style: TextStyle(
                        color: AppColors.white08,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      state.fullUser.jobTitle ?? 'No job :(',
                      style: const TextStyle(
                        color: AppColors.white08,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 16,
                // ),
                // Text(
                //   state.fullUser.description ?? 'No description',
                //   style: const TextStyle(
                //     color: AppColors.white08,
                //     fontSize: 18,
                //   ),
                //   textAlign: TextAlign.center,
                // )
              ],
            ),
            if (state.ownProfile)
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push<void>(EditProfilePage.route());
                  },
                  child: const Icon(
                    Icons.edit,
                    color: AppColors.white07,
                  ),
                ),
              )
            else
              const Align(
                alignment: Alignment.topRight,
                child: FollowButtonsWidget(),
              ),
            if (!state.ownProfile)
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.white07,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(ChatPage.route(state.fullUser.id));
                  },
                ),
              )
          ],
        ),
      );
    });
  }
}
