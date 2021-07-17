import 'package:flutter/material.dart';
import 'package:gpa_calculator/components/default_button.dart';
import 'package:gpa_calculator/components/gpa_percent.dart';
import 'package:gpa_calculator/components/appbar_icon.dart';
import 'package:gpa_calculator/constants.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/screens/add_edit_course_screen/add_course.dart';
import 'package:gpa_calculator/components/header.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CourseDetailsBody extends StatelessWidget {
  final Course course;

  CourseDetailsBody({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kPadding,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  AppbarIcon(
                    onTap: () => Navigator.pop(context),
                    tooltip: LocaleKeys.back.tr(),
                    icon: Icons.arrow_back,
                  ),
                  Header(
                      headerText: course.courseName, textColor: kPrimaryColor),
                  SizedBox(height: 30.0),
                  GPAPercent(
                    percent: courseFinalResult(course),
                    progressColor: kPrimaryColor,
                    textColor: kPrimaryColor,
                  ),
                  SizedBox(height: 40.0),
                  CourseDetailsTable(course: course),
                  SizedBox(height: 40.0),
                  EditButton(course: course),
                  SizedBox(height: 20.0),
                  DeleteButton(course: course),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: LocaleKeys.delete.tr(),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('${course.courseName} ${LocaleKeys.been_deleted.tr()}'),
          ),
        );
        course.delete();
        Navigator.pop(context);
      },
      bgColor: Colors.redAccent,
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: LocaleKeys.edit.tr(),
      onTap: () => Navigator.pushNamed(
        context,
        AddCourseScreen.routeName,
        arguments: ScreenArguments(course: course),
      ),
      bgColor: kPrimaryColor,
    );
  }
}

class CourseDetailsTable extends StatelessWidget {
  const CourseDetailsTable({
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FittedBox(
        child: DataTable(
          dataTextStyle: TextStyle(fontSize: 15.0, color: Colors.black),
          headingTextStyle: TextStyle(fontSize: 15.0, color: Colors.black),
          columnSpacing: 35.0,
          columns: [
            DataColumn(label: Text(LocaleKeys.course.tr())),
            DataColumn(label: Text(LocaleKeys.hw.tr())),
            DataColumn(label: Text(LocaleKeys.exam.tr())),
            DataColumn(label: Text(LocaleKeys.hours_table.tr())),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text(course.courseName)),
                DataCell(Text(course.hwResult.toStringAsFixed(2))),
                DataCell(Text(course.examResult.toStringAsFixed(2))),
                DataCell(Text(course.weight.toString())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

double courseFinalResult(Course course) {
  return ((course.examResult * 0.7) + (course.hwResult * 0.3)) / 100;
}
