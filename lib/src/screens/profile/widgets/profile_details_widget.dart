import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/profile/bloc/profile_bloc.dart';
import 'package:union_app/src/screens/edit_profile/view/edit_profile.dart';
import 'package:union_app/src/theme.dart';

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
                  photo: state.fullUser.photo,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state.fullUser.displayName ?? 'John Doe',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      state.fullUser.location ?? 'No location',
                      style: const TextStyle(
                        color: AppColors.white08,
                        fontSize: 16,
                      ),
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
                const SizedBox(
                  height: 16,
                ),
                Text(
                  state.fullUser.description ?? 'No description',
                  style: const TextStyle(
                    color: AppColors.white08,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            if (state.ownProfile) Align(
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
            ),
          ],
        ),
      );
    });
  }
}
