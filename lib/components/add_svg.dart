import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';

class AddSvg extends StatelessWidget {
  final double size;
  final String svgName;

  AddSvg({required this.size, required this.svgName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      kPaths[svgName]!,
      height: size,
    );
  }
}
