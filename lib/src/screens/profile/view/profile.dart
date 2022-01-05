import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/storage/firebase_user/firebase_user.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/screens/profile/widgets/posts/profile_posts_widget.dart';
import 'package:union_app/src/screens/profile/widgets/projects/project_list_widget.dart';
import 'package:union_app/src/screens/profile/widgets/stats/profile_statistics_widget.dart';
import 'package:union_app/src/screens/profile/widgets/profile_description_widget.dart';
import 'package:union_app/src/screens/widgets/app_bar/app_bar_with_search_bar.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/view/custom_nav_bar.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';
import 'package:union_app/src/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  static Route<void> route({required String uid}) {
    return MaterialPageRoute<void>(builder: (_) => ProfilePage(uid: uid));
  }

  static Page<void> page({required String uid}) => MaterialPage<void>(child: ProfilePage(uid: uid));

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: const PlusButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: const CustomNavBar(),
      drawer: const AppDrawer(),
      appBar: const AppBarWithSearchBar(),
      body: BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(
            uid: uid,
            userRepository: FirebaseUserRepository(),
            firebaseAuthRepository: context.read<AuthenticationRepository>()),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              ProfileDetailsWidget(),
              ProfileStatisticsWidget(),
              ProfileDescriptionWidget(),
              //InteractionMenuWidget(),

              ProfilePostsWidget(),

              // TestingProfileWidget(),
              // Flexible(
              //   child: ProjectListWidget(
              //     uid: uid,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
