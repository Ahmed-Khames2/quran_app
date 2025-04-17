// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة screenutil
import 'package:theam_mood_with_block/core/constant.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // نجيب الثيم الحالي

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الإعدادات",
          style: TextStyle(
            fontSize: 26.sp, // استخدام screenutil لحجم الخط
            fontWeight: FontWeight.bold,
            // fontFamily: 'me_quran',
            shadows: const [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
        backgroundColor: theme.primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.w), // استخدام screenutil في padding
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arabic Font Size:',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp, // استخدام screenutil لحجم الخط
                  ),
                ),
                Slider(
                  value: arabicFontSize,
                  min: 20,
                  max: 40,
                  activeColor: theme.colorScheme.secondary,
                  onChanged: (value) {
                    setState(() {
                      arabicFontSize = value;
                    });
                  },
                ),
                Text(
                  "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                  style: TextStyle(
                    fontFamily: 'quran',
                    fontSize: arabicFontSize.sp, // استخدام screenutil لحجم الخط
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                ),
                Text(
                  'Mushaf Mode Font Size:',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp, // استخدام screenutil لحجم الخط
                  ),
                ),
                Slider(
                  value: mushafFontSize,
                  min: 20,
                  max: 50,
                  activeColor: theme.colorScheme.secondary,
                  onChanged: (value) {
                    setState(() {
                      mushafFontSize = value;
                    });
                  },
                ),
                Text(
                  "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                  style: TextStyle(
                    fontFamily: 'quran',
                    fontSize: mushafFontSize.sp, // استخدام screenutil لحجم الخط
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          arabicFontSize = 28;
                          mushafFontSize = 40;
                        });
                        saveSettings();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 16.sp), // استخدام screenutil
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveSettings();
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 16.sp), // استخدام screenutil
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
