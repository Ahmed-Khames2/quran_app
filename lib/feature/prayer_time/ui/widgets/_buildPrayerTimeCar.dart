// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeCard extends StatelessWidget {
  final String title;
  final DateTime time;

  const PrayerTimeCard({
    super.key,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.primaryColor;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final cardColor = theme.cardColor;

    return Card(
      color: cardColor,
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.h), // استخدام ScreenUtil للأبعاد
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r), // استخدام ScreenUtil للتدوير
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h), // استخدام ScreenUtil للأبعاد
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  // ignore: deprecated_member_use
                  backgroundColor: iconColor.withOpacity(0.1),
                  child: Icon(_getPrayerIcon(title), color: iconColor),
                ),
                SizedBox(width: 12.w), // استخدام ScreenUtil للأبعاد
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp, // استخدام ScreenUtil لتحديد حجم الخط
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatTime(time),
                  style: TextStyle(
                    fontSize: 16.sp, // استخدام ScreenUtil لتحديد حجم الخط
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 4.h), // استخدام ScreenUtil للأبعاد
                Text(
                  timeOfDay(time),
                  style: TextStyle(
                    fontSize: 14.sp, // استخدام ScreenUtil لتحديد حجم الخط
                    // ignore: deprecated_member_use
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPrayerIcon(String title) {
    switch (title) {
      case 'الفجر':
        return Icons.wb_twilight;
      case 'الظهر':
        return Icons.wb_sunny;
      case 'العصر':
        return Icons.wb_cloudy;
      case 'المغرب':
        return Icons.nightlight;
      case 'العشاء':
        return Icons.nightlight_round;
      default:
        return Icons.access_time;
    }
  }

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String timeOfDay(DateTime time) {
    final hour = time.hour;
    if (hour < 12) return 'صباحًا';
    if (hour < 16) return 'ظهرًا';
    if (hour < 20) return 'مساءً';
    return 'ليلاً';
  }
}
