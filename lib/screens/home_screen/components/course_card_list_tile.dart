import 'package:flutter/material.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../functions.dart';

class CourseCardListTile extends StatelessWidget {
  const CourseCardListTile({
    required this.finalResult,
    required this.course,
  });

  final int finalResult;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Icon(
            Icons.brightness_1_rounded,
            color: finalResult > 60 ? Colors.green : Colors.redAccent,
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: ListTile(

              isThreeLine: true,
              title: Text(course.courseName),
              subtitle: Text(
                  '${LocaleKeys.hw.tr()}: ${course.hwResult.toStringAsFixed(2)}%\n${LocaleKeys.exam.tr()}: ${course.examResult.toStringAsFixed(2)}%'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(finalResult.toStringAsFixed(0) + '%'),
                  Text(letterGrade(finalResult * 1.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
