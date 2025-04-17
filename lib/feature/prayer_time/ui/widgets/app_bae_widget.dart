import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/select_city_page.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String cityName;
  final VoidCallback onSelectCity;

  const AppBarWidget(
      {super.key, required this.cityName, required this.onSelectCity});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Image(
        image: const AssetImage(
          'assets/icon/ChatGPT_Image_Apr_15__2025__05_13_05_AM-removebg-preview.png',
        ),
        height: 75.h, // استخدام ScreenUtil للأبعاد
        width: 150.w, // استخدام ScreenUtil للأبعاد
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 8.w), // استخدام ScreenUtil للأبعاد
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectCityPage()));
              onSelectCity();
            },
            child: Row(
              children: [
                Text(
                  cityName,
                  style: TextStyle(
                    fontSize: 18.sp, // استخدام ScreenUtil لحجم الخط
                    fontWeight: FontWeight.w600,
                    fontFamily: 'me_quran',
                  ),
                ),
                SizedBox(width: 8.w), // استخدام ScreenUtil للأبعاد
                Icon(
                  Icons.edit_location_alt,
                  size: 24.sp, // استخدام ScreenUtil لحجم الأيقونة
                ),
              ],
            ),
          ),
        ),
      ],
      backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal,
      elevation: 4,
    );
  }
}
