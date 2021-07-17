import 'package:flutter/material.dart';
import 'package:gpa_calculator/components/default_button.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:hive/hive.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';

class AddCourseForm extends StatefulWidget {
  final Course? courseToEdit;

  AddCourseForm({this.courseToEdit});

  @override
  _AddCourseFormState createState() => _AddCourseFormState();
}

class _AddCourseFormState extends State<AddCourseForm> {
  late final Course? _courseToEdit;
  final _formKey = GlobalKey<FormState>();
  String _courseName = '';
  double _hwResult = 0.0;
  double _examResult = 0.0;
  double _courseWeight = 0.0;
  int? _semester = -1;
  late TextEditingController _courseNameController;
  late TextEditingController _hwResultController;
  late TextEditingController _examResultController;
  late TextEditingController _courseWeightController;
  late TextEditingController _courseSemesterController;
  late FocusNode _courseNameNode;
  late FocusNode _hwNode;
  late FocusNode _examNode;
  late FocusNode _courseWeightNode;
  late FocusNode _semesterNode;
  bool helped = false;

  @override
  void initState() {
    super.initState();
    _courseToEdit = widget.courseToEdit;
    _courseNameController = TextEditingController();
    _hwResultController = TextEditingController();
    _examResultController = TextEditingController();
    _courseWeightController = TextEditingController();
    _courseSemesterController = TextEditingController();
    _courseNameNode = FocusNode();
    _hwNode = FocusNode();
    _examNode = FocusNode();
    _courseWeightNode = FocusNode();
    _semesterNode = FocusNode();
    if (_courseToEdit != null) {
      Course course = _courseToEdit!;
      _courseNameController.text = course.courseName;
      _hwResultController.text = course.hwResult.toString();
      _examResultController.text = course.examResult.toString();
      _courseWeightController.text = course.weight.toString();
      _courseSemesterController.text = course.semester.toString();
      _hwResult = course.hwResult;
      _examResult = course.examResult;
    }
  }

  @override
  void dispose() {
    _courseNameNode.dispose();
    _hwResultController.dispose();
    _examResultController.dispose();
    _courseWeightController.dispose();
    _courseSemesterController.dispose();
    _hwNode.dispose();
    _examNode.dispose();
    _courseWeightNode.dispose();
    _semesterNode.dispose();
    super.dispose();
  }

  requestFocus(FocusNode _focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_courseToEdit != null) {
        _courseToEdit!.courseName = _courseName;
        _courseToEdit!.hwResult = _hwResult;
        _courseToEdit!.examResult = _examResult;
        _courseToEdit!.weight = _courseWeight;
        _courseToEdit!.semester = _semester;
        _courseToEdit!.save();
        //context.locale.toString()
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.locale.toString() == 'ar'
                  ? '${LocaleKeys.been_updated.tr()} $_courseName.'
                  : '$_courseName ${LocaleKeys.been_updated.tr()}.',
            ),
          ),
        );
      } else {
        addCourse(
          courseName: _courseName,
          hwResult: _hwResult,
          examResult: _examResult,
          semester: _semester != null ? _semester : -1,
          weight: _courseWeight,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.locale.toString() == 'ar'
                  ? '${LocaleKeys.been_added.tr()} $_courseName.'
                  : '$_courseName ${LocaleKeys.been_added.tr()}.',
            ),
          ),
        );
      }
      Navigator.pop(context);
    }
    // print(_hwResult);
    // print(_examResult);
    // print(_courseName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _courseNameField(context),
          _courseResults(),
          SizedBox(height: 25.0),
          _courseCredits(),
          SizedBox(height: 25.0),
          _submitButton(),
          SizedBox(height: 25.0),
          (_courseToEdit != null) ? _deleteButton() : Container(),
        ],
      ),
    );
  }

  DefaultButton _submitButton() {
    return DefaultButton(
      text: _courseToEdit == null
          ? LocaleKeys.add_course.tr()
          : LocaleKeys.update.tr(),
      onTap: () => submit(),
      bgColor: kPrimaryColor,
    );
  }

  DefaultButton _deleteButton() {
    return DefaultButton(
      text: LocaleKeys.delete.tr(),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.locale.toString() == 'ar'
                  ? '${LocaleKeys.been_deleted.tr()} ${_courseToEdit!.courseName}.'
                  : '${_courseToEdit!.courseName} ${LocaleKeys.been_deleted.tr()}.',
            ),
          ),
        );
        _courseToEdit!.delete();
        Navigator.pop(context);
      },
      bgColor: Colors.redAccent,
    );
  }

  Row _courseResults() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          // HW Result TextFormField
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _hwNode,
            controller: _hwResultController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixText: '%',
              labelText: LocaleKeys.hw_result.tr(),
              labelStyle: TextStyle(
                fontSize: 18.0,
                color: _hwNode.hasFocus ? kPrimaryColor : Colors.black54,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (input) {
              if (input!.trim().isEmpty) return LocaleKeys.required.tr();
              if (!isNumeric(input)) return LocaleKeys.invalid.tr();
              if (isNumeric(input) && double.parse(input) > 100)
                return LocaleKeys.invalid.tr();
              return null;
            },
            onChanged: (input) {
              // In case of pasting a non-numeric value
              if (!isNumeric(input)) {
                _hwResultController.text = '';
              }
            },
            onSaved: (input) => _hwResult = double.parse(input!),
            onEditingComplete: () => requestFocus(_examNode),
          ),
        ),
        SizedBox(width: 20.0),
        Flexible(
          // Exam Result TextFormField
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _examNode,
            keyboardType: TextInputType.number,
            controller: _examResultController,
            decoration: InputDecoration(
              suffixText: '%',
              labelText: LocaleKeys.exam_result.tr(),
              labelStyle: TextStyle(
                fontSize: 18.0,
                color: _examNode.hasFocus ? kPrimaryColor : Colors.black54,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (input) {
              if (input!.trim().isEmpty) return LocaleKeys.required.tr();
              if (!isNumeric(input)) return LocaleKeys.invalid.tr();
              if (isNumeric(input) && double.parse(input) > 100)
                return LocaleKeys.invalid.tr();
              return null;
            },
            onChanged: (input) {
              // In case of pasting a non-numeric value
              if (!isNumeric(input)) {
                _examResultController.text = '';
              }
            },
            onSaved: (input) => _examResult = double.parse(input!),
            onEditingComplete: () => requestFocus(_courseWeightNode),
          ),
        ),
      ],
    );
  }

  Row _courseCredits() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          // Weight
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _courseWeightNode,
            controller: _courseWeightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixText: LocaleKeys.hours.tr(),
              labelText: LocaleKeys.course_weight.tr(),
              labelStyle: TextStyle(
                fontSize: 18.0,
                color:
                    _courseWeightNode.hasFocus ? kPrimaryColor : Colors.black54,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (input) {
              if (input!.trim().isEmpty) return LocaleKeys.required.tr();
              if (!isNumeric(input)) return LocaleKeys.invalid.tr();
              if (isNumeric(input) && double.parse(input) > 100)
                return LocaleKeys.invalid.tr();
              return null;
            },
            onChanged: (input) {
              // In case of pasting a non-numeric value
              if (!isNumeric(input)) {
                _courseWeightController.text = '';
              }
            },
            onSaved: (input) => _courseWeight = double.parse(input!),
            onEditingComplete: () => requestFocus(_semesterNode),
          ),
        ),
        SizedBox(width: 20.0),
        Flexible(
          // Semester
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _semesterNode,
            keyboardType: TextInputType.number,
            controller: _courseSemesterController,
            decoration: InputDecoration(
              hintText: LocaleKeys.optional.tr(),
              labelText: LocaleKeys.semester.tr(),
              labelStyle: TextStyle(
                fontSize: 18.0,
                color: _semesterNode.hasFocus ? kPrimaryColor : Colors.black54,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (input) {
              if (isNumeric(input!) && double.parse(input) > 30)
                return LocaleKeys.invalid.tr();
              return null;
            },
            onChanged: (input) {
              // In case of pasting a non-numeric value
              if (!isNumeric(input)) {
                _courseSemesterController.text = '';
              }
            },
            onSaved: (input) => _semester = 1,
            onEditingComplete: () => submit(),
          ),
        ),
      ],
    );
  }

  Padding _courseNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: TextFormField(
        controller: _courseNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: _courseNameNode,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: LocaleKeys.course_name_field.tr(),
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: _courseNameNode.hasFocus ? kPrimaryColor : Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        validator: (input) =>
            input!.trim().isEmpty ? LocaleKeys.course_name_error.tr() : null,
        onSaved: (input) => _courseName = input!,
        onEditingComplete: () => requestFocus(_hwNode),
      ),
    );
  }
}

Future addCourse({
  required String courseName,
  required double hwResult,
  required double examResult,
  required int? semester,
  required double weight,
}) async {
  final course = Course(
    courseName: courseName,
    hwResult: hwResult,
    examResult: examResult,
    semester: 1,
    weight: weight,
  );
  final box = Hive.box<Course>('Courses');
  await box.add(course);
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}
