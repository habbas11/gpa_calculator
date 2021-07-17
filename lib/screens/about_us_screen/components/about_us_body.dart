import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpa_calculator/constants.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutUsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.about.tr()),
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.0),
                SvgPicture.asset(
                  kPaths['appLogo']!,
                  height: 100.0,
                  width: 100.0,
                ),
                SizedBox(height: 10.0),
                VersionNumber()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VersionNumber extends StatelessWidget {
  const VersionNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          default:
            if (snapshot.hasError)
              print('Something went wrong!');
            else
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${snapshot.data![0]}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  // Text('Package Name: ${snapshot.data![1]}'),
                  Text('Version: ${snapshot.data![2]}'),
                  // Text('Build Number: ${snapshot.data![3]}'),
                  SizedBox(height: 50.0),
                  GestureDetector(
                    child: Text(
                      'Licenses',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF0645AD)),
                    ),
                    onTap: () => showLicensePage(
                        context: context,
                        applicationName: snapshot.data![0],
                        applicationIcon: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            kPaths['appLogoPng']!,
                            width: 48.0,
                            height: 48.0,
                          ),
                        ),
                        applicationLegalese: 'Copyright Segma®'),
                  ),
                ],
              );
        }
        return Container();
      },
    );
  }
}

Future<List<String>>? fetchData() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  return [appName, packageName, version, buildNumber];
}
