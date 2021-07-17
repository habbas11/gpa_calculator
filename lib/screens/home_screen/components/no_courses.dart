import 'package:flutter/material.dart';
import 'package:gpa_calculator/components/add_svg.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class NoCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddSvg(
          size: 100.0,
          svgName: 'noCourses',
        ),
        SizedBox(height: 20.0),
        Text(
          LocaleKeys.no_courses_first.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class AddCoursesNote extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.try_add.tr(),
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}