// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RetunBasmala extends StatelessWidget {
  const RetunBasmala({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            'بسم الله الرحمن الرحيم',
            style: TextStyle(fontFamily: 'me_quran', fontSize: 30.sp),
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
