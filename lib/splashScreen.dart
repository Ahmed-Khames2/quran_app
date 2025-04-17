import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/prayer_time_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // إضافة ScreenUtil

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // تأخير الانتقال لصفحة التطبيق الرئيسية لمدة 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const PrayerTimeScreen()),
      );
    });

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Logo
              Image.asset(
                'assets/icon/ChatGPT_Image_Apr_15__2025__05_13_05_AM-removebg-preview.png',
                width: 120.w, // استخدم ScreenUtil لتحديد العرض
                height: 150.h, // استخدم ScreenUtil لتحديد الارتفاع
              ),

              SizedBox(height: 200.h), // استخدم ScreenUtil لتحديد المسافة

              // ✅ App Name / Slogan
              Text(
                'تطبيق القدس',
                style: TextStyle(
                  fontSize: 24.sp, // استخدم ScreenUtil لتحديد حجم الخط
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                  fontFamily: 'me_quran',
                ),
              ),

              SizedBox(height: 12.h), // استخدم ScreenUtil لتحديد المسافة

              Text(
                'راحة لقلبك وطمأنينة لروحك',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp, // استخدم ScreenUtil لتحديد حجم الخط
                  // ignore: deprecated_member_use
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  fontFamily: 'me_quran',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: const Text('دعاء'),
    content: const Text(
      'اللهم ارحم خميس محمد، واغفر له، واجعل قبره روضة من رياض الجنة 🤲\n\n'
      'قال ﷺ: "إذا مات ابن آدم انقطع عمله إلا من ثلاث: صدقة جارية أو علم ينتفع به أو ولد صالح يدعو له."\n\n'
      'نسألكم الدعاء لروح خميس محمد.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('آمين'),
      ),
    ],
  ),
);

 */
