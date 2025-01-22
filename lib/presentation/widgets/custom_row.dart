import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String imagePath;
  final String title;
  final String tempC;

  const CustomRow({
    super.key,
    required this.imagePath,
    required this.title,
    required this.tempC,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Internetdan rasm yuklanmaguncha yuklanish indikatorini ko'rsatish
        Image.network(
          imagePath,
          width: 190,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child; // Agar yuklanish tugasa, haqiqiy rasmni ko'rsatadi
            } else {
              return Container(
                width: 190,
                height: 190,
                alignment: Alignment.center,
                child: CircularProgressIndicator(), // Yuklanish animatsiyasi
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              child: Icon(
                Icons.image_not_supported,
                size: 50,
                color: Colors.grey, // Xato holatida zaxira rasm yoki ikonka
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Bo'sh joy qo'shish
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$tempC",
                  style: const TextStyle(
                    color: Color(0xFF303345),
                    fontSize: 48,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    maxLines: 1,
                    title,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFF303345),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            const Text(
              '°C',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Color(0xFF303345),
                fontSize: 22,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ],
    );
  }
}
