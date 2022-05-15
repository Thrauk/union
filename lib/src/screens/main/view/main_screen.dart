import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/main/cubit/main_navigation_cubit.dart';
import 'package:union_app/src/screens/messaging/conversations/view/conversations_page.dart';
import 'package:union_app/src/screens/user_profile/profile/profile.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: MainPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainNavigationCubit>(
      create: (BuildContext context) => MainNavigationCubit(),
      child: const _MainPage(),
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = <Widget>[
      const HomePage(),
      ProfilePage(uid: context.read<AppBloc>().state.user.id),
      Container(),
      const ConversationsPage()
    ];

    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      buildWhen: (MainNavigationState previous, MainNavigationState current) {
        return previous.index != current.index;
      },
      builder: (BuildContext context, MainNavigationState state) {
        return Scaffold(
          bottomNavigationBar: CustomNavBar(
            index: state.index,
            onItemTapped: (int index) => context.read<MainNavigationCubit>().onIndexChanged(index),
          ),
          body: _screens[state.index],
        );
      },
    );
  }
}
