import 'package:flutter/widgets.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/intro/view/intro_page.dart';
import 'package:union_app/src/screens/profile/profile.dart';

List<Page<void>> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return <Page<void>>[HomePage.page()];
    case AppStatus.unauthenticated:
      return <Page<void>>[IntroPage.page()];
  }
}
