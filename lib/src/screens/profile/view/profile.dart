import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/repository/storage/firebase_user/firebase_user.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/screens/widgets/app_bar/app_bar_with_search_bar.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/view/custom_nav_bar.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  static Page page() => const MaterialPage<void>(child: ProfilePage());



  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    final AppUser user = context.select((AppBloc bloc) => bloc.state.user);
    String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      // floatingActionButton: const PlusButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: const CustomNavBar(),
      drawer: const AppDrawer(),
      appBar: const AppBarWithSearchBar(),
      /*AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const SizedBox(width: 25),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  filled: true,
                  fillColor: Colors.white70
              ),
            ),
          ),
        ),

      ),*/
      body: BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(uid: uid, userServiceRepository: FirebaseUserRepository()),
        child: SingleChildScrollView(
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: ProfileDetailsWidget(),
          ),
        ),
      ),
    );
  }
}
