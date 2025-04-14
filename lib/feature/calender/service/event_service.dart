import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/event_model.dart';

class EventService {
  static Future<List<EventModel>> loadEvents() async {
    final jsonString = await rootBundle.loadString('assets/json/events.json');
    final List data = jsonDecode(jsonString);
    return data.map((e) => EventModel.fromJson(e)).toList();
  }
}
