import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpa_calculator/screens/add_edit_course_screen/add_course.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';

class AddCourseFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      tooltip: LocaleKeys.add_course.tr(),
      onPressed: () async {
        await HapticFeedback.lightImpact();
        Navigator.pushNamed(context, AddCourseScreen.routeName,
            arguments: ScreenArguments());
      },
      child: Icon(Icons.add),
    );
  }
}
