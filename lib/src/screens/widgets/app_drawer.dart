import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/home/home.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppUser user = context.select((AppBloc bloc) => bloc.state.user);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size(100, 100),
            currentAccountPicture: Avatar(photo: user.photo),
            accountName: context.select(
              (AppBloc bloc) => Text(user.name ?? ''),
            ),
            accountEmail: context.select(
              (AppBloc bloc) => Text(user.email ?? ''),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.analytics,
              color: Colors.white70,
            ),
            title: Text('Projects'),
          ),
          const ListTile(
            leading: Icon(
              Icons.article,
              color: Colors.white70,
            ),
            title: Text('Articles'),
          ),
          const ListTile(
            leading: Icon(
              Icons.group,
              color: Colors.white70,
            ),
            title: Text('Organizations'),
          ),
          const ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white70,
            ),
            title: Text('Settings'),
          ),
          const ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white70,
            ),
            title: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
