import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // إضافة ScreenUtil
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_cubit.dart';
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_stare.dart';
import 'package:theam_mood_with_block/feature/Azkaritem/pages/azkaritempage.dart';
import 'package:theam_mood_with_block/feature/calender/pages/calenderpage.dart';
import 'package:theam_mood_with_block/feature/names_of_allah/pages/names_page.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/FeatureTile.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/QuranCard.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/mydrawerWidgets.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/prayer_icon.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/prayer_time_card.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/app_bae_widget.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/sallah_ala_mohamed.dart';
import 'package:theam_mood_with_block/feature/quran/pages/quran_home.dart';
import 'package:theam_mood_with_block/feature/ziker/pages/homepage.dart';

class PrayerTimeScreen extends StatelessWidget {
  const PrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          cityName: context.watch<PrayerCubit>().state.selectedCity?.name ?? '',
          onSelectCity: () {
            // فتح صفحة اختيار المدينة
          },
        ),
      ),
      drawer: const MyDrawer(),
      body: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.all(16.0.w), // استخدام ScreenUtil
            children: [
              SallahAlaMohamed(theme: theme),
              SizedBox(height: 24.h), // استخدام ScreenUtil

              // عنوان مواقيت الصلاة
              Text(
                'مواقيت الصلاة',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'me_quran',
                  fontSize: 24.sp, // استخدام ScreenUtil
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h), // استخدام ScreenUtil

              // بطاقات الصلاة
              PrayerTimeCard(
                title: 'الفجر',
                time: state.prayerTimes!.fajr,
                icon: getPrayerIcon('الفجر'),
              ),
              SizedBox(height: 12.h), // استخدام ScreenUtil
              PrayerTimeCard(
                title: 'الظهر',
                time: state.prayerTimes!.dhuhr,
                icon: getPrayerIcon('الظهر'),
              ),
              SizedBox(height: 12.h), // استخدام ScreenUtil
              PrayerTimeCard(
                title: 'العصر',
                time: state.prayerTimes!.asr,
                icon: getPrayerIcon('العصر'),
              ),
              SizedBox(height: 12.h), // استخدام ScreenUtil
              PrayerTimeCard(
                title: 'المغرب',
                time: state.prayerTimes!.maghrib,
                icon: getPrayerIcon('المغرب'),
              ),
              SizedBox(height: 12.h), // استخدام ScreenUtil
              PrayerTimeCard(
                title: 'العشاء',
                time: state.prayerTimes!.isha,
                icon: getPrayerIcon('العشاء'),
              ),

              SizedBox(height: 24.h), // استخدام ScreenUtil
              Divider(
                thickness: 1.5,
                indent: 30.w, // استخدام ScreenUtil
                endIndent: 30.w, // استخدام ScreenUtil
              ),
              SizedBox(height: 18.h), // استخدام ScreenUtil

              // القرآن
              Center(
                child: Text(
                  'اقرأ وردك اليومي',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'me_quran',
                    fontSize: 24.sp, // استخدام ScreenUtil
                  ),
                ),
              ),
              SizedBox(height: 12.h), // استخدام ScreenUtil
              QuranCard(onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QuranHome()));
              }),

              SizedBox(height: 24.h), // استخدام ScreenUtil

              // المميزات
              Text(
                'مميزات إضافية',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'me_quran',
                  fontSize: 24.sp, // استخدام ScreenUtil
                ),
              ),
              SizedBox(height: 12.h), // استخدام ScreenUtil
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.w, // استخدام ScreenUtil
                runSpacing: 16.h, // استخدام ScreenUtil
                children: [
                  FeatureTile(
                    icon: Icons.fingerprint,
                    label: "التسبيح",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DhikrPage()));
                    },
                  ),
                  FeatureTile(
                    icon: Icons.auto_stories,
                    label: "الأذكار",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AzkarHomePage()));
                    },
                  ),
                  FeatureTile(
                    icon: Icons.calendar_month,
                    label: "التقويم",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const IslamicCalendarPage()));
                    },
                  ),
                  FeatureTile(
                    icon: Icons.star,
                    label: " أسماء الله الحسنى",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NamesOfAllahPage()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 32.h), // استخدام ScreenUtil
            ],
          );
        },
      ),
    );
  }
}
