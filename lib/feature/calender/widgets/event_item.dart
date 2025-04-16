import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // إضافة المكتبة هنا
import '../models/event_model.dart';

class EventItem extends StatelessWidget {
  final EventModel event;
  final String formattedDate;

  const EventItem({super.key, required this.event, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        event.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp, // استخدام ScreenUtil لتحديد حجم النص
        ),
      ),
      subtitle: Text(
        formattedDate,
        style: TextStyle(
          fontSize: 12.sp, // استخدام ScreenUtil لتحديد حجم النص
        ),
      ),
    );
  }
}
