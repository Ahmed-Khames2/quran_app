import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theam_mood_with_block/core/theme/app_theme.dart';
import 'package:theam_mood_with_block/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة الإعدادات لتغيير الثيم.
class SettingPage extends StatelessWidget {
  final String id = '/setting';
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إعدادات التطبيق',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      // عرض قائمة بالثيمات المتاحة باستخدام ListView.builder
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: AppTheme.values.length,
        itemBuilder: (context, index) {
          final itemAppTheme = AppTheme.values[index];
          return Card(
            // تغيير لون البطاقة بناءً على الثيم الأساسي الحالي
            color: appThemeData[itemAppTheme]!.primaryColor,
            child: ListTile(
              // عرض اسم الثيم باستخدام الخاصية name
              title: Center(
                child: Text(
                  itemAppTheme.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'me_quran',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                ),
              ),
              onTap: () {
                // عند الضغط على عنصر القائمة، يتم تغيير الثيم عبر ThemeBloc.
                context.read<ThemeBloc>().add(ChangeThemeEvent(itemAppTheme));
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
