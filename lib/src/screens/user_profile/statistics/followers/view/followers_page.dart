import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/firestore/firebase_user/barrel.dart';
import 'package:union_app/src/screens/user_profile/profile/view/profile.dart';
import 'package:union_app/src/screens/user_profile/statistics/bloc/get_users_bloc.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/exceptions/barrel.dart';
import 'package:union_app/src/screens/widgets/exceptions/empty_page_widget.dart';
import 'package:union_app/src/screens/widgets/user_item/user_item_widget.dart';
import 'package:union_app/src/theme.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key, required List<String> uids})
      : _uids = uids,
        super(key: key);

  static Route<void> route(List<String> uids) {
    return MaterialPageRoute<void>(builder: (_) => FollowersPage(uids: uids));
  }

  final List<String> _uids;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Followers'),
      body: BlocProvider<GetUsersBloc>(
        create: (BuildContext context) => GetUsersBloc(FirebaseUserRepository())..add(GetUsers(_uids)),
        child: const _FollowersPage(),
      ),
    );
  }
}

class _FollowersPage extends StatelessWidget {
  const _FollowersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersBloc, GetUsersState>(
      buildWhen: (GetUsersState previous, GetUsersState current) {
        return previous.pageStatus != current.pageStatus || previous.users != current.users;
      },
      builder: (BuildContext context, GetUsersState state) {
        return Column(
          children: <Widget>[
            Builder(
              builder: (BuildContext context) {
                switch (state.pageStatus) {
                  case PageStatus.LOADING:
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  case PageStatus.SUCCESSFUL:
                    {
                      if (state.users.isEmpty) {
                        return const Expanded(child: EmptyPageWidget(message: 'No followers yet!'));
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: state.users.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return UserItemWidget(
                              user: state.users[index],
                              onTap: (_) {
                                Navigator.of(context).push(ProfilePage.route(uid: state.users[index].id));
                              },
                            );
                          },
                        );
                      }
                    }
                  case PageStatus.FAILED:
                    return const Expanded(child: SomethingWentWrongWidget());
                }
              },
            )
          ],
        );
      },
    );
  }
}
