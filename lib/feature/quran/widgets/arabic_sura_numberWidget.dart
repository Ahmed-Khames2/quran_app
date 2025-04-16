// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/core/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد screenutil

class ArabicSuraNumber extends StatelessWidget {
  const ArabicSuraNumber({super.key, required this.i});
  final int i;

  @override
  Widget build(BuildContext context) {
    return Text(
      "\uFD3F${(i + 1).toString().toArabicNumbers}\uFD3E", // عرض الرقم بالعربية
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontFamily: 'me_quran',
        fontSize: 20.sp, // استخدام screenutil لحجم الخط
        shadows: const [
          Shadow(
            offset: Offset(.5, .5),
            blurRadius: 1.0,
            color: Colors.amberAccent,
          ),
        ],
      ),
    );
  }
}
