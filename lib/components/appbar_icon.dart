import 'package:flutter/material.dart';

class AppbarIcon extends StatelessWidget {
  AppbarIcon({required this.onTap, required this.icon, required this.tooltip});

  final Function onTap;
  final IconData icon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onTap as void Function()?,
          icon: Icon(icon, size: 30.0),
          tooltip: tooltip,
        ),
      ],
    );
  }
}
