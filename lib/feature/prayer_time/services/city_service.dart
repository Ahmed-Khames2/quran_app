import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/city_model.dart';

class CityService {
  static Future<List<CityModel>> loadCities() async {
    final jsonString = await rootBundle.loadString('assets/json/egypt_cities.json');
    final jsonData = json.decode(jsonString);

    final citiesList = jsonData[0]['cities'] as List;
    return citiesList.map((city) => CityModel.fromJson(city)).toList();
  }
}
