// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/home/widgets/widgets.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppUser user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavBar(),
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user.photo),
            const SizedBox(height: 4),
            Text(user.email ?? '', style: textTheme.headline6),
            const SizedBox(height: 4),
            Text(user.displayName ?? '', style: textTheme.headline5),
          ],
        ),
      ),
    );
  }
}
