import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/design/design.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/repository/storage/firebase_user_service/firebase_user_service.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/home/widgets/widgets.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EditProfilePage());
  }

  static Page page() => const MaterialPage<void>(child: EditProfilePage());



  @override
  Widget build(BuildContext context) {
    final AppUser user = context.select((AppBloc bloc) => bloc.state.user);
    String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Center(child: Text('Edit profile'))
      ),
      body: BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(uid: uid, userServiceRepository: FirebaseUserServiceRepository()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Avatar(
                  photo: null,
                ),
                SizedBox(
                  height: 15,
                ),

                TextField(
                  cursorColor: Colors.white,
                  decoration: TextFieldProprieties.revolutishInputDecoration(
                      labelText: 'Display name',
                      hintText: 'Display name'
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  cursorColor: Colors.white,
                  decoration: TextFieldProprieties.revolutishInputDecoration(
                    labelText: 'Job title',
                    hintText: 'Job title',
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  cursorColor: Colors.white,
                  decoration: TextFieldProprieties.revolutishInputDecoration(
                    labelText: 'Location',
                    hintText: 'Location',
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  cursorColor: Colors.white,
                  decoration: TextFieldProprieties.revolutishInputDecoration(
                    labelText: 'Description',
                    hintText: 'Description',
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.transparent,
                    onSurface: Colors.transparent,
                    shadowColor: Colors.transparent,
                    side: const BorderSide(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



