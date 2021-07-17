import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/about_us_screen/about_us.dart';
import 'package:gpa_calculator/screens/add_edit_course_screen/add_course.dart';
import 'package:gpa_calculator/screens/course_details_screen/course_details.dart';
import 'package:gpa_calculator/screens/home_screen/home_screen.dart';
import 'package:gpa_calculator/screens/settings_screen/settings.dart';

final Map<String, WidgetBuilder> routes = {
  AddCourseScreen.routeName: (_) => AddCourseScreen(),
  HomeScreen.routeName: (_) => HomeScreen(),
  CourseDetails.routeName: (_) => CourseDetails(),
  SettingsScreen.routeName: (_) => SettingsScreen(),
  AboutUs.routeName: (_) => AboutUs(),
};
