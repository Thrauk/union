import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({
    Key? key,
    this.isLoaded = false,
    this.child,
    this.color = AppColors.primaryColor,
  }) : super(key: key);

  final bool isLoaded;
  final Widget? child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if(!isLoaded) {
      return Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      );
    } else {
      return child ?? Container();
    }
  }
}
