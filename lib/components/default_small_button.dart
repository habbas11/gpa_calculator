import 'package:flutter/material.dart';

class DefaultSmallButton extends StatelessWidget {
  const DefaultSmallButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.bgColor,
  }) : super(key: key);
  final String text;
  final Function onTap;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onTap as void Function()?,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
