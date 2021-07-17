import 'package:flutter/material.dart';
import 'package:gpa_calculator/models/course.dart';
import 'components/add_course_body.dart';

class AddCourseScreen extends StatelessWidget {
  static String routeName = '/add_course_screen';

  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return AddCourseScreenBody(courseToEdit: args.course);
  }
}

class ScreenArguments {
  final Course? course;

  ScreenArguments({this.course});
}
