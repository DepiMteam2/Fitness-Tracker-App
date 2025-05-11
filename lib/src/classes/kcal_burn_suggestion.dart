class KcalBurnSuggestion {
  final double targetKcal;

  KcalBurnSuggestion({required this.targetKcal});

  double getWalkingDistanceKm() => targetKcal / 50;
  double getSleepHours() => targetKcal / (0.42 * 60);
  double getWaterLitersNeeded() => targetKcal / 25;

  String getWorkoutSuggestion() {
    if (targetKcal <= 100) return "Light yoga or stretching for 20 minutes";
    if (targetKcal <= 200) return "Jogging or cycling for 30 minutes";
    if (targetKcal <= 300) return "HIIT or fast walking for 40 minutes";
    return "Intense cardio or gym session for 45-60 minutes";
  }

  Map<String, dynamic> getSuggestionsSummary() {
    return {
      "kcal": targetKcal.toStringAsFixed(0),
      "walk_km": getWalkingDistanceKm().toStringAsFixed(2),
      "sleep_hours": getSleepHours().toStringAsFixed(1),
      "water_liters": getWaterLitersNeeded().toStringAsFixed(1),
      "workout": getWorkoutSuggestion(),
    };
  }
}