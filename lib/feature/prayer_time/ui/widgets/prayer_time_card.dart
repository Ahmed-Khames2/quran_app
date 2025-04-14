import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerTimeCard extends StatelessWidget {
  final String title;
  final DateTime time;
  final IconData icon;

  const PrayerTimeCard({
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
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.primaryColor), // استخدم اللون الرئيسي من الثيم
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyLarge?.color, // استخدم اللون النص من الثيم
                ),
              ),
            ],
          ),
          Text(
            '${formatTime(time)} - ${timeOfDay(time)}',
            style: TextStyle(
              fontSize: 16,
              color: theme.textTheme.bodyMedium?.color, // استخدم لون النص من الثيم
            ),
          ),
        ],
      ),
    );
  }
}
