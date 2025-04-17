// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/core/constant.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/setting_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          // 🔷 Header with branding and close button
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35.r, // استخدم .r لجعل الحجم responsive
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage(
                          'assets/icon/ChatGPT_Image_Apr_15__2025__05_13_05_AM-removebg-preview.png'),
                    ),
                    SizedBox(
                        width: 12.w), // استخدم .w لتحديد المسافة بين العناصر
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Al-Quds App',
                          style: TextStyle(
                            fontSize: 22.sp, // استخدم .sp لتحديد حجم الخط
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height: 4.h), // استخدم .h لتحديد المسافة الرأسية
                        Text(
                          'راحة لقلبك وطمأنينة لروحك',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                            fontFamily: 'me_quran',
                            // textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: -17.h,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Drawer Items
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text(
                    'الإعدادات',
                    style: TextStyle(
                      fontFamily: 'me_quran',
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ),
                    );
                  },
                ),
                const Divider(thickness: 1, height: 24),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text(
                    'مشاركة التطبيق',
                    style: TextStyle(
                      fontFamily: 'me_quran',
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Share.share(
                    //   'جرب تطبيق القرآن الكريم 🌙\nhttps://github.com/Ahmed-Khames2',
                    // );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.rate_review),
                  title: const Text(
                    'قيّم التطبيق',
                    style: TextStyle(
                      fontFamily: 'me_quran',
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    if (!await launchUrl(
                      quranAppurl,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw 'Could not launch $quranAppurl';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text(
                    'عن التطبيق',
                    style: TextStyle(
                      fontFamily: 'me_quran',
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "Al-Quds App",
                      applicationVersion: "1.0.0",
                      applicationIcon: Image.asset(
                          'assets/icon/ChatGPT_Image_Apr_15__2025__05_13_05_AM-removebg-preview.png',
                          height: 40.h), // استخدم .h لتحديد الارتفاع
                      children: const [
                        Text(
                          "تطبيق قرآن كريم بسيط وسهل الاستخدام، صمم خصيصًا ليكون رفيقك اليومي في التلاوة والتدبر.",
                          style: TextStyle(
                            fontFamily: 'me_quran',
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: const Text(
                    'تواصل معنا',
                    style: TextStyle(
                      fontFamily: 'me_quran',
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'ahmedkh45891@gmail.com',
                      query: Uri.encodeFull('subject=اقتراح لتطبيق القرآن'),
                    );
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri,
                          mode: LaunchMode.externalApplication);
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تعذر فتح تطبيق البريد')),
                      );
                    }
                  },
                ),
                const Divider(thickness: 1, height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h), // استخدم .w و .h لتحديد المسافة
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(
                          12.r), // استخدم .r لتحديد نصف القطر
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.volunteer_activism,
                          color: Colors.green),
                      title: Text(
                        'قال ﷺ: "إذا مات ابن آدم انقطع عمله إلا من ثلاث: '
                        'صدقة جارية، أو علم يُنتفع به، أو ولد صالح يدعو له."\n'
                        'نسألكم الدعاء لوالدي خميس محمد بالرحمة والمغفرة 🤲',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: theme.primaryColor,
                          fontFamily: 'me_quran',
                          // height: 1.,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔻 Footer
          Padding(
            padding: EdgeInsets.only(
                bottom: 12.h), // استخدم .h لتحديد المسافة السفلية
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.code,
                    size: 16.sp,
                    color: Colors.grey.shade600), // استخدم .sp لتحديد الحجم
                SizedBox(width: 4.w), // استخدم .w لتحديد المسافة بين العناصر
                Text(
                  'Developed by Ahmed Khames',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp, // استخدم .sp لتحديد الحجم

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
