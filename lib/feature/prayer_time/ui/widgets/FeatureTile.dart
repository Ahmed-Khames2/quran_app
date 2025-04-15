import 'package:flutter/material.dart';
// import 'package:theam_mood_with_block/theme/app_theme.dart'; // تأكد من استيراد ملف الثيمات الخاص بك

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const FeatureTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // جلب الثيم الحالي من التطبيق
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.cardColor, // استخدم اللون المناسب من الثيم
            child: Icon(
              icon,
              size: 30,
              color: theme.iconTheme.color, // استخدم اللون الرئيسي من الثيم
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'me_quran',
              color: theme.textTheme.bodyLarge?.color, // استخدم اللون من الثيم
            ),
          ),
        ],
      ),
    );
  }
}
