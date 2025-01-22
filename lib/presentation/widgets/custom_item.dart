import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String imagePath;
  final String now;
  final String gradus;

  const CustomItem({
    super.key,
    required this.imagePath,
    required this.now,
    required this.gradus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 65,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x14000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              now,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF303345),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.network(imagePath),
            Text(
              '$gradus °',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF303345),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
