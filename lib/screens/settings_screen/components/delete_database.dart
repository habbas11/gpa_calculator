import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gpa_calculator/components/default_button.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:hive/hive.dart';
import 'package:easy_localization/easy_localization.dart';

class DeleteDatabase extends StatelessWidget {
  const DeleteDatabase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: LocaleKeys.delete_database.tr(),
      onTap: () async {
        await Hive.box<Course>('courses').clear();
        Fluttertoast.showToast(msg: LocaleKeys.successful_deletion.tr());
      },
      bgColor: Colors.redAccent,
    );
  }
}
