import 'package:flutter/material.dart';
import 'package:gpa_calculator/constants.dart';
import 'package:gpa_calculator/screens/about_us_screen/about_us.dart';
import 'package:gpa_calculator/screens/settings_screen/settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Text(
                'GPA Calculator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(LocaleKeys.settings.tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
              // await context.setLocale(context.supportedLocales[1]);
              // await context.setLocale(context.fallbackLocale!);
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(LocaleKeys.about.tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutUs.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
