import 'package:flutter/material.dart';

class ForcastCon extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;

  const ForcastCon({
    super.key,
    required this.iconPath,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 237, 235, 234).withOpacity(0.6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF303345),
              fontSize: 15,
              fontFamily: '22',
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF303345),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Image.network(width: 50, iconPath),
              SizedBox(
                height: 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
