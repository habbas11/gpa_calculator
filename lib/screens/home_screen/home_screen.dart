import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'components/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) => HomeScreenBody(),
      ),
    );
  }
}
