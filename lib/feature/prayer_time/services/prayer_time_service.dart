import 'package:adhan/adhan.dart';

class PrayerTimeService {
  final Coordinates coordinates;

  PrayerTimeService(this.coordinates);

  PrayerTimes getPrayerTimes(DateTime date) {
    final params = CalculationMethod.muslim_world_league.getParameters();
    final prayerTimes = PrayerTimes.today(coordinates, params);
    return prayerTimes;
  }
}