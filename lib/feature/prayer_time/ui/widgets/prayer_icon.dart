import 'package:flutter/material.dart';

IconData getPrayerIcon(String title) {
  switch (title) {
    case 'الفجر':
      return Icons.wb_twilight;
    case 'الظهر':
      return Icons.wb_sunny;
    case 'العصر':
      return Icons.cloud;
    case 'المغرب':
      return Icons.nights_stay;
    case 'العشاء':
      return Icons.dark_mode;
    default:
      return Icons.access_time;
  }
}
