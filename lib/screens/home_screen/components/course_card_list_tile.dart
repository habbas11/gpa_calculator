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
    return ListTile(
      isThreeLine: true,
      leading: Icon(
        Icons.brightness_1_rounded,
        color: finalResult > 60 ? Colors.green : Colors.redAccent,
      ),
      title: Text(course.courseName),
      subtitle: Text(
          '${LocaleKeys.hw.tr()}: ${course.hwResult.toStringAsFixed(2)}%\n${LocaleKeys.exam.tr()}: ${course.examResult.toStringAsFixed(2)}%'),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(finalResult.toStringAsFixed(0) + '%'),
          Text(letterGrade(finalResult * 1.0)),
          Text(percentGrade(finalResult * 1.0).toString()),
        ],
      ),
    );
  }
}
