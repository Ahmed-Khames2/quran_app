import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/city_service.dart';
class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  List<CityModel> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCities();
  }

  Future<void> loadCities() async {
    final loadedCities = await CityService.loadCities();
    setState(() {
      cities = loadedCities;
      isLoading = false;
    });
  }

  Future<void> _showConfirmDialog(CityModel city) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تأكيد تغيير المدينة',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp, // استخدام ScreenUtil لتحديد حجم الخط
              ),
        ),
        content: Text(
          'هل أنت متأكد أنك تريد تغيير المدينة إلى ${city.name}؟',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16.sp,
              ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'إلغاء',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14.sp, // استخدام ScreenUtil لتحديد حجم الخط
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'تأكيد',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );

    if (isConfirmed == true) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, city);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اختر المدينة",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp, // استخدام ScreenUtil لتحديد حجم الخط
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            )
          : ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w), // استخدام ScreenUtil للأبعاد
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r), // استخدام ScreenUtil للتدوير
                  ),
                  child: ListTile(
                    title: Text(
                      city.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 16.sp, // استخدام ScreenUtil لتحديد حجم الخط
                      ),
                    ),
                    onTap: () => _showConfirmDialog(city),
                  ),
                );
              },
            ),
    );
  }
}
