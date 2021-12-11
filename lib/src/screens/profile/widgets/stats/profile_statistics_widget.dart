import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/screens/profile/widgets/stats/profile_stat_element_widget.dart';
import 'package:union_app/src/theme.dart';

class ProfileStatisticsWidget extends StatelessWidget {
  const ProfileStatisticsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              title: 'Followers',
              data: '0',
              buttonType: StatButton.LeftRounded,
            )),
            const VerticalDividerWidget(),
            Expanded(
              child: ProfileStatElementWidget(
                onPressed: () {},
                title: 'Following',
                data: '0',
                buttonType: StatButton.NoRounded,
              ),
            ),
            const VerticalDividerWidget(),
            Expanded(
              child: ProfileStatElementWidget(
                onPressed: () {},
                title: 'Rating',
                data: '5/5',
                buttonType: StatButton.RightRounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
