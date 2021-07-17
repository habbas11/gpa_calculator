import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({required this.headerText, required this.textColor});

  final String headerText;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
