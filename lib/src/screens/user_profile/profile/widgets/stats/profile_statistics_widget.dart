import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/user_profile/profile/profile.dart';
import 'package:union_app/src/screens/user_profile/statistics/followers/view/followers_page.dart';
import 'package:union_app/src/theme.dart';

class ProfileStatisticsWidget extends StatelessWidget {
  const ProfileStatisticsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            height: 75,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColors.backgroundLight,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ProfileStatElementWidget(
                    onPressed: () {
                      Navigator.of(context).push(FollowersPage.route(
                          state.fullUser.followers?.map((dynamic e) => e.toString()).toList() ?? <String>[]));
                    },
                    title: 'Followers',
                    data: state.fullUser.followers?.length.toString(),
                    buttonType: StatButton.LeftRounded,
                  ),
                ),
                const VerticalDividerWidget(),
                Expanded(
                  child: ProfileStatElementWidget(
                    onPressed: () {
                      Navigator.of(context).push(FollowersPage.route(
                          state.fullUser.following?.map((dynamic e) => e.toString()).toList() ?? <String>[]));
                    },
                    title: 'Following',
                    data: state.fullUser.following?.length.toString(),
                    buttonType: StatButton.NoRounded,
                  ),
                ),
                const VerticalDividerWidget(),
                Expanded(
                  child: ProfileStatElementWidget(
                    onPressed: () {},
                    title: 'Rating',
                    data: 'N/A',
                    buttonType: StatButton.RightRounded,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
