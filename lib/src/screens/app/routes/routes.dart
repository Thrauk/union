import 'package:flutter/widgets.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/auth/login/login.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/intro/intro.dart';

List<Page<void>> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return <Page<void>>[HomePage.page()];
    case AppStatus.unauthenticated:
      return <Page<void>>[IntroPage.page()];
  }
}
