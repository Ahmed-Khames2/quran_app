import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/select_city_page.dart';
import 'package:theam_mood_with_block/pages/setting_page.dart';

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
      leading: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SettingPage()));
        },
      ),
      title: const Text(
        "Al-Quds",
        style: TextStyle(
          fontSize: 34,
          fontFamily: 'me_quran',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2.0,
              color: Colors.black26,
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.edit_location_alt)
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
