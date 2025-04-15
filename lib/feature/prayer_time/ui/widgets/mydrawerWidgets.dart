import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/core/constant.dart';
import 'package:theam_mood_with_block/pages/setting_page.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart';

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
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                          'assets/icon/ChatGPT_Image_Apr_15__2025__05_13_05_AM-removebg-preview.png'),
                    ),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Al-Quran App',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'رحلة روحانية يومية ✨',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: -17,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                  title: const Text('الإعدادات'),
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
                  title: const Text('مشاركة التطبيق'),
                  onTap: () {
                    // Share.share(
                    //   'جرب تطبيق القرآن الكريم 🌙\nhttps://github.com/Ahmed-Khames2',
                    // );
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.rate_review),
                  title: const Text('قيّم التطبيق'),
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
                  title: const Text('عن التطبيق'),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "Al-Quran App",
                      applicationVersion: "1.0.0",
                      applicationIcon:
                          Image.asset('assets/icon/quran.png', height: 40),
                      children: const [
                        Text(
                            "تطبيق قرآن كريم بسيط وسهل الاستخدام، صمم خصيصًا ليكون رفيقك اليومي في التلاوة والتدبر."),
                      ],
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: const Text('تواصل معنا'),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تعذر فتح تطبيق البريد')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          // 🔻 Footer
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.code, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  'Developed by Ahmed Khames',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
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