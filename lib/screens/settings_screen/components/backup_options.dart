import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gpa_calculator/models/course.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'backup_card.dart';
import 'package:easy_localization/easy_localization.dart';

class BackupOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BackupCard(
              processName: LocaleKeys.export.tr(),
              onTap: () => export,
              iconData: Icons.arrow_circle_up_outlined,
            ),
            SizedBox(width: 20.0),
            BackupCard(
              processName: LocaleKeys.import.tr(),
              onTap: () => import,
              iconData: Icons.arrow_circle_down_outlined,
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Platform.isAndroid || Platform.isIOS
            ? BackupCard(
                processName: LocaleKeys.send.tr(),
                onTap: () => sendDatabase,
                iconData: Icons.send_rounded,
              )
            : Container(),
      ],
    );
  }
}

void sendDatabase() {
  Share.shareFiles(
    ['${Hive.box<Course>('Courses').path}'],
    subject: LocaleKeys.send_subject.tr(),
    text: '${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
  );
}

void import() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    if (file.extension != 'hive') {
      if (kIsWeb || Platform.isAndroid || Platform.isIOS)
        Fluttertoast.showToast(msg: LocaleKeys.choose_hive.tr());
      print('Unsupported file');
    } else
      restoreHiveBox<Course>('Courses', file.path!);
  }
}

void export() async {
  String? result = await FilePicker.platform.getDirectoryPath();
  if (result != null) {
    backupHiveBox<Course>('Courses', result);
    print(result.toString());
  }
}

Future<void> backupHiveBox<T>(String boxName, String backupPath) async {
  final boxPath = Hive.box<T>(boxName).path;
  await Hive.box<T>(boxName).close();
  var status = await Permission.storage.request();
  if (!status.isGranted) {
    await Hive.openBox<T>(boxName);
  } else {
    if (Platform.isAndroid || Platform.isIOS)
      await Permission.storage.request();
    final String time = DateFormat('ss-mm-hh|dd-MMM-yy').format(DateTime.now());
    try {
      File(boxPath!).copy(backupPath + '/$time-$boxName.hive');
      if (kIsWeb || Platform.isAndroid || Platform.isIOS)
        Fluttertoast.showToast(msg: LocaleKeys.successful_backup.tr());
    } finally {
      await Hive.openBox<T>(boxName);
    }
  }
}

Future<void> restoreHiveBox<T>(String boxName, String backupPath) async {
  final boxPath = Hive.box<T>(boxName).path;
  await Hive.box<T>(boxName).close();
  try {
    File(backupPath).copy(boxPath!);
    if (kIsWeb || Platform.isAndroid || Platform.isIOS)
      Fluttertoast.showToast(msg: LocaleKeys.successful_restore.tr());
  } finally {
    await Hive.openBox<T>(boxName);
  }
}
