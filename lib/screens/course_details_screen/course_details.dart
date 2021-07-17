import 'package:flutter/material.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/screens/course_details_screen/components/course_details_body.dart';

class CourseDetails extends StatelessWidget {
  static String routeName = '/course_details';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return CourseDetailsBody(course: args.course!);
  }
}

class ScreenArguments {
  final Course? course;

  ScreenArguments({this.course});
}
