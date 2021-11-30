import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
   const SimpleAppBar({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  final Size preferredSize = const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w600,
      ),),
      backgroundColor: AppColors.backgroundLight,
      elevation: 8,
    );
  }
}
