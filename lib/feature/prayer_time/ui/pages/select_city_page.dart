import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/city_service.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/prayer_time_screen.dart';

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
    final theme = Theme.of(context);

    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'تأكيد تغيير المدينة',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: 'me_quran',
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'هل أنت متأكد أنك تريد تغيير المدينة إلى ${city.name}؟',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16.sp,
            fontFamily: 'me_quran',
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontSize: 14.sp,
                color: theme.iconTheme.color,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.iconTheme.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            onPressed: () {
              // Navigator.pop(context, true);
               Navigator.pop(context, true); // Close the dialog
            // Use pushReplacement to replace current page with PrayerTimeScreen
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PrayerTimeScreen(city: city), // Pass the selected city
            //   ),
            // );
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerTimeScreen()));
            }, // Return true to confirm
            child: Text(
              'تأكيد',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    // Now handle the return after the dialog closes
    if (isConfirmed == true) {
      Navigator.pop(context, city); // Send city back to the previous page
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اختيار المدينة',
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16.0.w),
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];

                return GestureDetector(
                  onTap: () => _showConfirmDialog(city),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 3,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      tileColor: theme.cardColor,
                      leading: Icon(
                        Icons.location_on,
                        color: theme.iconTheme.color,
                      ),
                      title: Text(
                        city.name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 18.sp,
                          fontFamily: 'me_quran',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.sp,
                        color: theme.iconTheme.color,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
