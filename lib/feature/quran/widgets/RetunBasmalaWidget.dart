
import 'package:flutter/material.dart';

class RetunBasmala extends StatelessWidget {
  const RetunBasmala({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: Text(
            'بسم الله الرحمن الرحيم',
            style: TextStyle(fontFamily: 'me_quran', fontSize: 30),
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}