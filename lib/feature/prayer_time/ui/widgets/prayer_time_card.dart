import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة screenutil

class PrayerTimeCard extends StatelessWidget {
  final String title;
  final DateTime time;
  final IconData icon;

  const PrayerTimeCard({super.key, 
    required this.title,
    required this.time,
    required this.icon,
  });

  String formatTime(DateTime time) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(time);
  }

  String timeOfDay(DateTime time) {
    return (time.hour >= 12) ? 'مساء' : 'صباح';
  }

  @override
  Widget build(BuildContext context) {
    // جلب الثيم الحالي من التطبيق
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0.h), // استخدام screenutil للـ padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.iconTheme.color),
              SizedBox(width: 8.w), // استخدام screenutil للـ spacing
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.sp, // استخدام screenutil لحجم الخط
                  fontWeight: FontWeight.w600,
                  fontFamily: 'me_quran',
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          Text(
            '${formatTime(time)} - ${timeOfDay(time)}',
            style: TextStyle(
              fontSize: 16.sp, // استخدام screenutil لحجم الخط
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
