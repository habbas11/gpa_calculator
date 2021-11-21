import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:gpa_calculator/translations/locale_keys.g.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../functions.dart';

class GPAPercent extends StatelessWidget {
  const GPAPercent({
    required this.percent,
    required this.progressColor,
    required this.textColor,
  });

  final double percent;
  final Color progressColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 220.0,
          lineWidth: 8.0,
          animation: true,
          percent: percent,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (percent * 100).toStringAsFixed(1) + '%',
                style: TextStyle(fontSize: 40.0, color: textColor),
              ),
              const SizedBox(height: 20.0),
              Text(
                '${LocaleKeys.letter_grade.tr()}: ' + letterGrade(percent * 100.0),
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                '${LocaleKeys.gpa_scale.tr()}: ' + percentGrade(percent * 100.0).toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: progressColor,
        ),
      ],
    );
  }
}
