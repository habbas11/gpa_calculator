import 'package:flutter/material.dart';
import 'package:gpa_calculator/components/default_small_button.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';

class ChangeLanguageOptions extends StatelessWidget {
  const ChangeLanguageOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultSmallButton(
          text: 'العربيّة',
          onTap: () async {
            await context.setLocale(context.supportedLocales[1]);
            print(context.locale);
          },
          bgColor: kPrimaryColor,
        ),
        SizedBox(width: 10.0),
        DefaultSmallButton(
          text: 'English',
          onTap: () async =>
              await context.setLocale(context.supportedLocales[0]),
          bgColor: kPrimaryColor,
        ),
      ],
    );
  }
}
