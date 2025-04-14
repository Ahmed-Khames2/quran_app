import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theam_mood_with_block/core/theme/bloc/theme_bloc.dart';
import 'package:theam_mood_with_block/cubitss/azkar_cubit/favorite_cubit.dart';
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_cubit.dart';
import 'package:theam_mood_with_block/cubitss/tasbeeh_cubit/tasbeeh_cubit.dart';
import 'package:theam_mood_with_block/core/theme/app_theme.dart';
import 'package:theam_mood_with_block/feature/calender/pages/calenderpage.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/home_screen.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/prayer_time_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('ar_EG', ''); // Changed null to empty string

  // تهيئة المنطقة الزمنية
  tzData.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  // طلب إذن الإشعارات
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // إعداد الإشعارات
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()..add(GetCuurrentThemeEvent())),
        BlocProvider(create: (context) => TasbeehCubit()),
        BlocProvider(create: (context) => FavoriteCubit(prefs: prefs)),
        BlocProvider(create: (context) => PrayerCubit()..loadSelectedCity()), // ✅ أضفنا ده
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is LoadingThemeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: const Locale('ar', 'EG'),
              supportedLocales: const [
                Locale('ar', 'EG'),
                Locale('en', 'US'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: appThemeData[state.appTheme]!,
              home: PrayerTimeScreen(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
