import 'package:bloc/bloc.dart';
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_stare.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/prayer_time_service.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/location_service.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/city_service.dart';
import 'package:adhan/adhan.dart';

// The main Cubit for handling logic
class PrayerCubit extends Cubit<PrayerState> {
  final LocationService locationService;
  final PrayerTimeService prayerTimeService;

  PrayerCubit({
    required this.locationService,
    required this.prayerTimeService,
  }) : super(PrayerInitial());

  Future<void> getLocation() async {
    try {
      emit(PrayerLoading());
      final position = await locationService.getCurrentLocation();
      final coordinates = Coordinates(position.latitude, position.longitude);
      emit(LocationLoaded(coordinates));
      _loadPrayerTimes(coordinates);
    } catch (e) {
      emit(PrayerError('فشل تحديد الموقع: $e'));
    }
  }

  Future<void> _loadPrayerTimes(Coordinates coordinates) async {
    try {
      final prayerTimes = await prayerTimeService.getPrayerTimes(coordinates as DateTime);
      emit(PrayerTimesLoaded(prayerTimes));
    } catch (e) {
      emit(PrayerError('فشل تحميل مواقيت الصلاة: $e'));
    }
  }
  Future<void> loadCities() async {
    try {
      final cities = await CityService.loadCities();
      emit(CitiesLoaded(cities));
    } catch (e) {
      emit(PrayerError('فشل تحميل المدن: $e'));
    }
  }

  Future<void> selectCity(CityModel city) async {
    final coordinates = Coordinates(city.lat, city.lng);
    _loadPrayerTimes(coordinates);
  }
}
