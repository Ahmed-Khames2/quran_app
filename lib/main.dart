import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theam_mood_with_block/core/theme/bloc/theme_bloc.dart';
import 'package:theam_mood_with_block/cubitss/azkar_cubit/favorite_cubit.dart';
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_cubit.dart';
import 'package:theam_mood_with_block/cubitss/tasbeeh_cubit/tasbeeh_cubit.dart';
import 'package:theam_mood_with_block/core/theme/app_theme.dart';
// import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:theam_mood_with_block/test.dart';
// ignore: library_prefixes
import 'package:timezone/data/latest.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ import ScreenUtil

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tzData.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

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
    return ScreenUtilInit(
      designSize: const Size(375, 812), // ✅ المقاس الأساسي للتصميم (iPhone X مثلاً)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ThemeBloc()..add(GetCuurrentThemeEvent())),
            BlocProvider(create: (context) => TasbeehCubit()),
            BlocProvider(create: (context) => FavoriteCubit(prefs: prefs)),
            BlocProvider(create: (context) => PrayerCubit()..loadSelectedCity()),
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
                  home: const SplashScreen(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
