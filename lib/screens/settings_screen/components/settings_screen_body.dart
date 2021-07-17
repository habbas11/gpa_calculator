import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:easy_localization/easy_localization.dart';
import 'package:gpa_calculator/components/appbar_icon.dart';
import 'package:gpa_calculator/components/header.dart';
import 'package:gpa_calculator/constants.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'backup_options.dart';
import 'delete_database.dart';
import 'language_options.dart';

class SettingsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppbarIcon(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.arrow_back,
                  tooltip: LocaleKeys.back.tr(),
                ),
                Center(
                  child: Header(
                    headerText: LocaleKeys.settings.tr(),
                    textColor: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 40.0),
                Text(LocaleKeys.change_language.tr() + ':',
                    style: TextStyle(fontSize: (20.0))),
                SizedBox(height: 30.0),
                ChangeLanguageOptions(),
                SizedBox(height: 40.0),
                (!kIsWeb && (Platform.isAndroid || Platform.isIOS)  ) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.backup_database.tr() + ':',
                        style: TextStyle(fontSize: (20.0))),
                    SizedBox(height: 30.0),
                    BackupOptions(),
                    SizedBox(height: 40.0),
                  ],
                ) : Container(),
                Text(LocaleKeys.delete_database.tr() + ':',
                    style: TextStyle(fontSize: (20.0))),
                SizedBox(height: 30.0),
                DeleteDatabase(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
