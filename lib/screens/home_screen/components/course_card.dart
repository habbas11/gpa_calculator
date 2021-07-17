import 'package:flutter/material.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/screens/course_details_screen/course_details.dart';
import 'course_card_list_tile.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.finalResult,
    required this.course,
    required this.index,
  });

  final int finalResult;
  final Course course;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            CourseDetails.routeName,
            arguments: ScreenArguments(course: course),
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: index == 0 ? 12.0 : 0.0,
          ),
          child: CourseCardListTile(finalResult: finalResult, course: course),
        ),
      ),
    );
  }
}
