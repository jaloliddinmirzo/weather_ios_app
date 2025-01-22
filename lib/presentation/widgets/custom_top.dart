import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconWithTitle extends StatelessWidget {
  final String assetPath;
  final String title;
  final double iconWidth;
  final double containerWidth;
  final double containerRadius;
  final Color containerColor;
  final TextStyle? textStyle;

  const CustomIconWithTitle({
    super.key,
    required this.assetPath,
    required this.title,
    this.iconWidth = 40,
    this.containerWidth = 40,
    this.containerRadius = 15,
    this.containerColor = const Color(0xffFAFAF6),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          width: containerWidth,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(containerRadius),
          ),
          child: SvgPicture.asset(
            assetPath,
            width: iconWidth,
          ),
        ),
        const SizedBox(height: 5), // Bo'sh joy
        Text(
          title,
          style: textStyle ??
              const TextStyle(
                color: Color(0xFF303345),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
