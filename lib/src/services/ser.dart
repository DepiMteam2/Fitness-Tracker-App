import 'dart:async';

import 'package:fitness_app/src/models/sleep_model.dart';

class SleepService {
  Future<List<SleepModel>> fetchTodaySleepData() async {
    // ممكن هنا تربط بـ Google Fit API لاحقًا
    await Future.delayed(const Duration(seconds: 2));

    return [
      SleepModel(
        timeRange: '6am - 7am',
        duration: const Duration(hours: 1, minutes: 20),
        freshness: 36,
      ),
      SleepModel(
        timeRange: '10pm - 2am',
        duration: const Duration(hours: 4, minutes: 10),
        freshness: -50,
      ),
    ];
  }
}
