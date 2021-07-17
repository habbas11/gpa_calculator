import 'package:flutter/material.dart';
import 'package:gpa_calculator/components/appbar_icon.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import '../../../constants.dart';
import 'add_course_form.dart';
import '../../../components/add_svg.dart';
import '../../../components/header.dart';
import 'package:easy_localization/easy_localization.dart';

class AddCourseScreenBody extends StatelessWidget {
  final Course? courseToEdit;

  AddCourseScreenBody({this.courseToEdit});

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: kPadding,
              child: Column(
                children: [
                  AppbarIcon(
                    onTap: () => Navigator.pop(context),
                    icon: Icons.arrow_back,
                    tooltip: LocaleKeys.back.tr(),
                  ),
                  Header(
                    headerText: courseToEdit == null
                        ? LocaleKeys.add_new_course_header.tr()
                        : LocaleKeys.edit_course.tr(),
                    textColor: kPrimaryColor,
                  ),
                  SizedBox(height: 20.0),
                  AddSvg(size: 100.0, svgName: 'addCourseSvg'),
                  AddCourseForm(courseToEdit: courseToEdit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
