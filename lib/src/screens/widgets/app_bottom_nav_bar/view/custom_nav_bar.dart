import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/messaging/conversations/view/conversations_page.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/widgets/plus_button.dart';
import 'package:union_app/src/theme.dart';

import '../app_bottom_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBottomNavBarCubit>(
      create: (_) => AppBottomNavBarCubit(),
      child: _CustomNavBar(),
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBottomNavBarCubit, AppBottomNavBarState>(
      builder: (BuildContext context, AppBottomNavBarState state) {
        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: BottomNavigationBar(
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  unselectedItemColor: AppColors.white07,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.backgroundDark,
                  currentIndex: context.read<AppBottomNavBarCubit>().state.index,
                  onTap: (int index) {
                    context.read<AppBottomNavBarCubit>().navigate(index);
                    switch (index) {
                      case 0:
                        Navigator.of(context).push(HomePage.route());
                        break;
                      case 3:
                        Navigator.of(context).push(ConversationsPage.route());
                    }
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                    BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
                    BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
                  ],
                  selectedItemColor: AppColors.primaryColor,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: double.infinity,
                      color: AppColors.backgroundDark,
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: PlusButton(),
                      ))),
            ],
          ),
        );
      },
    );
  }
}
