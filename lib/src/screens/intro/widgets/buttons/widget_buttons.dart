import 'package:flutter/material.dart';
import 'package:union_app/src/screens/intro/widgets/buttons/widget_buttons_01.dart';
import 'package:union_app/src/screens/intro/widgets/buttons/widget_buttons_02.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    Widget returnedWidget;
    switch(currentPage) {
      case 0:
        returnedWidget = ButtonsWidget01();
        break;
      case 1:
        returnedWidget = ButtonsWidget01();
        break;
      case 2:
        returnedWidget = ButtonsWidget02();
        break;
      default:
        returnedWidget = ButtonsWidget01();
    }
    return returnedWidget;

  }

}