import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/screens/course_details_screen/course_details.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
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
        onLongPress: () async {
          await HapticFeedback.lightImpact();
          Fluttertoast.showToast(msg: LocaleKeys.swipe.tr());
        },
        onTap: () {
          Navigator.pushNamed(
            context,
            CourseDetails.routeName,
            arguments: ScreenArguments(course: course),
          );
        },
        child: CourseCardListTile(finalResult: finalResult, course: course),
      ),
    );
  }
}
