import 'package:flutter/material.dart';
import 'buttons_widget_01.dart';
import 'buttons_widget_02.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({Key? key, required this.currentPage}) : super(key: key);

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    Widget returnedWidget;
    switch(currentPage) {
      case 0:
        returnedWidget = const ButtonsWidget01();
        break;
      case 1:
        returnedWidget = const ButtonsWidget01();
        break;
      case 2:
        returnedWidget = const ButtonsWidget02();
        break;
      default:
        returnedWidget = const ButtonsWidget01();
        break;
    }
    return returnedWidget;

  }

}
