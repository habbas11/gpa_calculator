import 'package:flutter/material.dart';
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
          center: Text(
            (percent * 100).toStringAsFixed(1) + '%',
            style: TextStyle(fontSize: 40.0, color: textColor),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: progressColor,
        ),
        const SizedBox(height: 20.0),
        Text(
          'Letter Grade: ' + letterGrade(percent * 100.0),
          style: TextStyle(
            color: textColor,
            fontSize: 15.0,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'GPA Scale: ' + percentGrade(percent * 100.0).toString(),
          style: TextStyle(
            color: textColor,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
