import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import 'package:union_app/src/theme.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBottomNavBarCubit>(
      create: (_) => AppBottomNavBarCubit(),
      child: _AppBottomNavBar(),
    );
  }
}

class _AppBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBottomNavBarCubit, AppBottomNavBarState>(
      builder: (BuildContext context, AppBottomNavBarState state) {
        return BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          unselectedItemColor: AppColors.white07,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundLight,
          currentIndex: context.read<AppBottomNavBarCubit>().state.index,
          onTap: (int index) {
            context.read<AppBottomNavBarCubit>().navigate(index);
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(
              label: 'Add',
              icon: ElevatedButton(
                onPressed: () {
                  // for test
                  Navigator.of(context).push(CreateProjectPage.route());
                },
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    shape: const CircleBorder()),
                child: const Icon(
                  Icons.add,
                  color: AppColors.backgroundDark,
                ),
              ),
            ),
          ],
          selectedItemColor: AppColors.primaryColor,
        );
      },
    );
  }
}
