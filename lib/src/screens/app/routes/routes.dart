import 'package:flutter/widgets.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/intro/view/intro_page.dart';

import '../app.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [IntroPage.page()];
  }
}