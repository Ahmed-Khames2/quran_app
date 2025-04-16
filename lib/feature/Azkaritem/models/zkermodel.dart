import 'package:flutter/material.dart';
// import '../models/zkermodel.dart'; // التأكد من استيراد ZekrModel

class AzkarItem {
  final String title;
  final IconData icon;
  final List<ZekrModel> azkarTexts; // تغيير النوع إلى ZekrModel

  AzkarItem({
    required this.title,
    required this.icon,
    required this.azkarTexts,
  });
}

class ZekrModel {
  final String text;
  final int repeat;

  ZekrModel({
    required this.text,
    required this.repeat,
  });
}
