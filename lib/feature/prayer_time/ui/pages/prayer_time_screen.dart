import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_cubit.dart';
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_stare.dart';
import 'package:theam_mood_with_block/feature/Azkaritem/pages/azkaritempage.dart';
import 'package:theam_mood_with_block/feature/calender/pages/calenderpage.dart';
import 'package:theam_mood_with_block/feature/names_of_allah/pages/names_page.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/FeatureTile.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/QuranCard.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/prayer_icon.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/prayer_time_card.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/app_bae_widget.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/widgets/sallah_ala_mohamed.dart';
import 'package:theam_mood_with_block/feature/quran/pages/quran_home.dart';
import 'package:theam_mood_with_block/feature/ziker/pages/homepage.dart';

class PrayerTimeScreen extends StatelessWidget {
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
      body: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SallahAlaMohamed(theme: theme),
              const SizedBox(height: 24.0),

              // عنوان مواقيت الصلاة
              Text(
                'مواقيت الصلاة',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),

              // بطاقات الصلاة
              PrayerTimeCard(
                title: 'الفجر',
                time: state.prayerTimes!.fajr,
                icon: getPrayerIcon('الفجر'),
              ),
              const SizedBox(height: 12.0),
              PrayerTimeCard(
                title: 'الظهر',
                time: state.prayerTimes!.dhuhr,
                icon: getPrayerIcon('الظهر'),
              ),
              const SizedBox(height: 12.0),
              PrayerTimeCard(
                title: 'العصر',
                time: state.prayerTimes!.asr,
                icon: getPrayerIcon('العصر'),
              ),
              const SizedBox(height: 12.0),
              PrayerTimeCard(
                title: 'المغرب',
                time: state.prayerTimes!.maghrib,
                icon: getPrayerIcon('المغرب'),
              ),
              const SizedBox(height: 12.0),
              PrayerTimeCard(
                title: 'العشاء',
                time: state.prayerTimes!.isha,
                icon: getPrayerIcon('العشاء'),
              ),

              const SizedBox(height: 24.0),
              const Divider(
                thickness: 1.5,
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(height: 24.0),

              // القرآن
              Center(
                child: Text(
                  'اقرأ وردك اليومي',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              QuranCard(onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QuranHome()));
              }),

              const SizedBox(height: 24.0),

              // المميزات
              Text(
                'مميزات إضافية',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12.0),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 16,
                children: [
                  FeatureTile(
                    icon: Icons.fingerprint,
                    label: "التسبيح",
                    onTap: () {
                      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DhikrPage()));
  
                    },
                  ),
                  FeatureTile(
                    icon: Icons.auto_stories,
                    label: "الأذكار",
                    onTap: () {
                      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AzkarHomePage()));
  
                    },
                  ),
                  FeatureTile(
                    icon: Icons.calendar_month,
                    label: "التقويم",
                    onTap: () {
                      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const IslamicCalendarPage()));
  
                    },
                  ),
                  FeatureTile(
                    icon: Icons.star,
                    label: "أسماء الله",
                    onTap: () {
                      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NamesOfAllahPage()));
  
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }
}
