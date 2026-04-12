import 'dart:convert';
import 'package:http/http.dart' as http;
import 'StartUpInfo.dart';

class StartupInfoService {
  Future<StartupInfo> fetchStartupInfo() async {
    try {
      // 🌍 Step 1: IP-based location
      final ipData = await _fetchIPLocation();

      final latitude = ipData['lat'];
      final longitude = ipData['lon'];

      // 🌤 Step 2: Weather
      final weatherData = await _fetchWeatherData(
        latitude: latitude,
        longitude: longitude,
      );

      final current = Map<String, dynamic>.from(weatherData['current'] ?? {});

      // 🧠 Step 3: Build UI data
      final city = ipData['city'] ?? 'Unknown city';
      final state = ipData['regionName'] ?? 'Unknown state';
      final country = ipData['country'] ?? 'Unknown country';

      final fullAddress = "$city, $state, $country";

      final localTime = _cleanDateTimeText(current['time'] ?? '');

      return StartupInfo(
        landmarkOrCircle: city,
        area: city,
        city: city,
        state: state,
        country: country,
        fullAddress: fullAddress,
        timezone: weatherData['timezone'] ?? 'Unknown',
        timezoneAbbreviation: weatherData['timezone_abbreviation'] ?? '',
        localTime: localTime,
        isDay: ((current['is_day'] ?? 0) as num).toInt() == 1,
        temperature: (current['temperature_2m'] ?? '').toString(),
      );
    } catch (e) {
      // 🔥 NEVER CRASH — return fallback data
      return StartupInfo(
        landmarkOrCircle: 'Unknown',
        area: 'Unknown',
        city: 'Unknown',
        state: 'Unknown',
        country: 'Unknown',
        fullAddress: 'Unable to fetch location',
        timezone: 'Unknown',
        timezoneAbbreviation: '',
        localTime: 'Unknown',
        isDay: true,
        temperature: '25',
        outfitSuggestion: '',
      );
    }
  }

  /// 🌍 IP location API
  Future<Map<String, dynamic>> _fetchIPLocation() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json/'));

    if (response.statusCode != 200) {
      throw Exception('IP location failed');
    }

    return jsonDecode(response.body);
  }

  /// 🌤 Weather API (Open-Meteo)
  Future<Map<String, dynamic>> _fetchWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.https(
      'api.open-meteo.com',
      '/v1/forecast',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,is_day',
        'timezone': 'auto',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Weather API failed');
    }

    return jsonDecode(response.body);
  }

  String _cleanDateTimeText(String value) {
    if (value.isEmpty) return 'Unknown';
    return value.replaceFirst('T', ' ');
  }
}
