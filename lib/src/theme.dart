import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  unselectedWidgetColor: AppColors.white07,
  hintColor: const Color.fromRGBO(255, 255, 255, 0.7),
  primaryColorDark: const Color.fromRGBO(18, 18, 18, 1),
  primaryColorLight: const Color.fromRGBO(215, 223, 113, 1),
  primaryColor: const Color.fromRGBO(169, 223, 216, 1),
  colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
  scaffoldBackgroundColor: const Color.fromRGBO(12, 12, 12, 1),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.7), fontFamily: 'Lato'),
    headline6: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        fontWeight: FontWeight.w700,
        fontFamily: 'Lato'),
  ),
  canvasColor: const Color.fromRGBO(18, 18, 18, 1),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(
      color: AppColors.primaryColor,
    ),
    hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.7)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(169, 223, 216, 1),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(255, 255, 255, 0.7),
      ),
    ),
  ),
);

class AppStyles {
  static const TextStyle textStyleHeading1 = TextStyle(
    fontFamily: 'Lato',
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static const TextStyle textStyleHeadingWhite20 = TextStyle(
    fontFamily: 'Lato',
    color: AppColors.white09,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );


  static const TextStyle textStyleHeading2 = TextStyle(
    fontFamily: 'Lato',
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: 32,
  );

  static const TextStyle textStyleBody = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.normal,
    color: AppColors.white08,
    fontSize: 16,
  );

  static const TextStyle textStyleBodyDark = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.normal,
    color: AppColors.backgroundDark,
    fontSize: 16,
  );

  static const TextStyle textStyleBodyBig = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.normal,
    color: AppColors.white08,
    fontSize: 18,
  );

  static const TextStyle textStyleBodySmall = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.normal,
    color: AppColors.white05,
    fontSize: 14,
  );

  static const TextStyle textStyleBodySmallDark = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.normal,
    color: AppColors.black09,
    fontSize: 14,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundLight,
    fontSize: 18,
  );

  static const TextStyle buttonTextStylePrimaryColor = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.normal,
    color: AppColors.primaryColor,
    fontSize: 18,
  );

}

class AppColors {
  static const Color primaryColor = Color.fromRGBO(169, 223, 216, 1);
  static const Color accentColor = Color.fromRGBO(215, 223, 113, 1);
  static const Color backgroundLight = Color.fromRGBO(33, 33, 33, 1);
  static const Color backgroundLight1 = Color.fromRGBO(51, 51, 51, 1);
  static const Color backgroundDark = Color.fromRGBO(18, 18, 18, 1);

  static const Color white02 = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color white05 = Color.fromRGBO(255, 255, 255, 0.5);
  static const Color white07 = Color.fromRGBO(255, 255, 255, 0.7);
  static const Color white08 = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color white09 = Color.fromRGBO(255, 255, 255, 0.9);

  static const Color black09 = Color.fromRGBO(0, 0, 0, 0.9);

  static const Color greenLight = Color.fromRGBO(100, 255, 100, 1);
  static const Color redLight = Color.fromRGBO(255, 100, 100, 1);


}
