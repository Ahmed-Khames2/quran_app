import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة screenutil

class SallahAlaMohamed extends StatelessWidget {
  const SallahAlaMohamed({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'اللهم صلِّ وسلم على نبينا محمد',
            style: TextStyle(
              fontSize: 30.sp, // استخدام screenutil لحجم الخط
              fontWeight: FontWeight.bold,
              fontFamily: 'me_quran', // Custom font if available
              color: theme.textTheme.titleLarge?.color ?? 
                     theme.appBarTheme.backgroundColor, // Text color adapts to theme
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h), // استخدام screenutil للمسافات بين العناصر
          // يمكنك إضافة عناصر أو وظائف إضافية حسب الحاجة
        ],
      ),
    );
  }
}

            // 'صلِّ على محمد ﷺ',
