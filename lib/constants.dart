import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color kPrimaryColor = Color(0xFF002154);
ThemeData myThemeData = ThemeData(
  primaryColor: Color(0xFF003654),
  backgroundColor: Color(0xFFf1f3fa),
  errorColor: Color(0xFFFD7D7F),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder().copyWith(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    focusColor: kPrimaryColor,
    labelStyle: TextStyle(color: kPrimaryColor),
  ),
  fontFamily: "Montserrat",
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: kPrimaryColor),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    gapPadding: 10.0,
  );
}

final kPaths = {
  'addCourseSvg': 'assets/images/add_course.svg',
  'noCourses': 'assets/images/no_courses.svg',
  'export': 'assets/images/export.svg',
  'import': 'assets/images/import.svg',
  'appLogo': 'assets/icons/app_icon.svg',
  'appLogoPng': 'assets/icons/launcher_icon.png',
};

EdgeInsetsGeometry kPadding = EdgeInsets.symmetric(
  horizontal: 25,
  vertical: 15.0,
);
