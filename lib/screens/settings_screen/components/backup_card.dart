import 'package:flutter/material.dart';

import '../../../constants.dart';

class BackupCard extends StatelessWidget {
  BackupCard({
    required this.processName,
    required this.onTap,
    required this.iconData,
  });

  final String processName;
  final Function onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap(),
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(
                iconData,
                size: 100.0,
                color: kPrimaryColor,
              ),
              Text(
                processName,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
