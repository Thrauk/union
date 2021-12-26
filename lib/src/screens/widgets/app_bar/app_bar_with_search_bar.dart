import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class AppBarWithSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWithSearchBar({Key? key}) : super(key: key);

  @override
  final Size preferredSize = const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: 40,
        // borderRadius: BorderRadius.circular(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: AppColors.backgroundLight),
        // color: AppColors.backgroundLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
          child: Row(
            children: const <Widget>[
              Icon(Icons.search),
              SizedBox(width: 6),
              Expanded(
                child: TextField(
                  style: AppStyles.textStyleBody,
                  cursorColor: AppColors.white07,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search something...'),
                ),
              ),
              // Text('Search something...', style: AppStyles.textStyleBody)
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundDark,
      elevation: 8,
    );
  }
}
