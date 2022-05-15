import 'package:flutter/widgets.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/intro/intro.dart';
import 'package:union_app/src/screens/main/view/main_screen.dart';

List<Page<void>> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return <Page<void>>[MainPage.page()];
    case AppStatus.unauthenticated:
      return <Page<void>>[IntroPage.page()];
  }
}
