import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
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
        showPlatformDialog(
          androidBarrierDismissible: true,
          context: context,
          builder: (context) => BasicDialogAlert(
            content: Text(
              LocaleKeys.sure.tr(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  LocaleKeys.cancel.tr(),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.red.shade50),
                ),
                onPressed: () async {
                  try {
                    await Hive.box<Course>('courses').clear();
                    Fluttertoast.showToast(
                      msg: LocaleKeys.successful_deletion.tr(),
                    );
                  } catch (err) {
                    Fluttertoast.showToast(
                      msg: LocaleKeys.went_wrong.tr(),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  LocaleKeys.delete.tr(),
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      bgColor: Colors.redAccent,
    );
  }
}
