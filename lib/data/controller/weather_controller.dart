import 'package:flutter/cupertino.dart';

import '../../presentation/screens/startUp/StartUpInfo.dart';
import '../../presentation/screens/startUp/StartupInfoService.dart';

class WeatherController extends ChangeNotifier {
  final StartupInfoService _service = StartupInfoService();

  StartupInfo? currentWeather;

  bool isLoading = false;
  bool isFetchingSuggestion = false;
  String? error;

  bool get hasData => currentWeather != null;

  WeatherController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      currentWeather = await _service.fetchStartupInfo();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async => init();

  // 🌤 YOUR REAL WEATHER LOGIC (FROM StartupInfo)
  String get weatherMain => currentWeather?.weatherCondition ?? "Pleasant";

  String get dayNight => currentWeather?.dayNightText ?? "Day";

  double get temperature =>
      double.tryParse(currentWeather?.temperature ?? "25") ?? 25.0;
}
