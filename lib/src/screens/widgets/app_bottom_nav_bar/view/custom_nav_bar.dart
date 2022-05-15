import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/widgets/plus_button.dart';
import 'package:union_app/src/theme.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key, int index = 0, required Function(int) onItemTapped})
      : _index = index,
        _onItemTapped = onItemTapped,
        super(key: key);

  final int _index;
  final Function(int) _onItemTapped;

  @override
  Widget build(BuildContext context) {
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
              currentIndex: _index,
              onTap: (int index) => _onItemTapped(index),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
