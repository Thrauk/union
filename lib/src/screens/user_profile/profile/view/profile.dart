import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/user_profile/profile/widgets/posts/profile_posts_widget.dart';
import 'package:union_app/src/screens/user_profile/profile/widgets/profile_description_widget.dart';
import 'package:union_app/src/screens/widgets/app_bar/app_bar_with_search_bar.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';

import '../profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  static Route<void> route({required String uid}) {
    return MaterialPageRoute<void>(builder: (_) => ProfilePage(uid: uid));
  }

  static Page<void> page({required String uid}) => MaterialPage<void>(child: ProfilePage(uid: uid));

  final String uid;

  @override
  Widget build(BuildContext context) {
    final String _loggedUid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      drawer: _loggedUid == uid ? const AppDrawer() : null,
      appBar: const AppBarWithSearchBar(),
      body: BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(
          uid: uid,
          userRepository: FirebaseUserRepository(),
          firebaseAuthRepository: context.read<AuthenticationRepository>(),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              ProfileDetailsWidget(),
              ProfileStatisticsWidget(),
              ProfileDescriptionWidget(),
              ProfilePostsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
