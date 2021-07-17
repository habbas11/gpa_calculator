import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gpa_calculator/routes.dart';
import 'package:gpa_calculator/screens/home_screen/home_screen.dart';
import 'package:gpa_calculator/translations/codegen_loader.g.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants.dart';
import 'models/course.dart';
import 'package:easy_localization/easy_localization.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS))
    await DesktopWindow.setMinWindowSize(const Size(500, 645));
  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  await Hive.openBox<Course>('Courses');
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'GPA Calculator',
      theme: buildThemeData(context),
      routes: routes,
      initialRoute: HomeScreen.routeName,
    );
  }

  ThemeData buildThemeData(BuildContext context) {
    return ThemeData(
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
      fontFamily: context.locale.toString() == 'ar' ? "Cairo" : "Montserrat",
      // fontFamily: "Montserrat",
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: kPrimaryColor),
    );
  }
}
