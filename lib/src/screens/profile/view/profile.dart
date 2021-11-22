import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/repository/storage/firebase_user_service/firebase_user_service.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/home/widgets/widgets.dart';
import 'package:union_app/src/screens/profile/profile.dart';
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
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: SizedBox(width: 25),
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

      ),
      body: BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(uid: uid, userServiceRepository: FirebaseUserServiceRepository()),
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
