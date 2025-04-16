// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة screenutil

class QuranCard extends StatelessWidget {
  final Function onTap;

  const QuranCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(16.w), // استخدام screenutil للـ padding
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), // استخدام screenutil للمارجين
        decoration: BoxDecoration(
          color: theme.cardColor, // The background color will follow the theme.
          borderRadius: BorderRadius.circular(20.r), // استخدام screenutil للتدوير
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.r, // استخدام screenutil للـ blur radius
              offset: Offset(0, 4.h), // استخدام screenutil للـ offset
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w), // استخدام screenutil للـ padding
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.menu_book_rounded,
                color: const Color.fromARGB(255, 226, 219, 136),
                size: 28.sp, // استخدام screenutil لحجم الأيقونة
              ),
            ),
            SizedBox(width: 16.w), // استخدام screenutil للمسافات
            Text(
              "القرآن الكريم",
              style: TextStyle(
                fontSize: 18.sp, // استخدام screenutil لحجم الخط
                fontWeight: FontWeight.bold,
                fontFamily: 'me_quran',
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
