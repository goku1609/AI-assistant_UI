// lib/services/ip_startup_info_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/startUp/StartUpInfo.dart';

/// Service that fetches weather and location data using IP geolocation.
/// No device location permission is required.
class IpStartupInfoService {
  /// Main method to fetch all data without any permission dialog.
  Future<StartupInfo> fetchStartupInfo() async {
    // 1. Get approximate location from IP address
    final ipData = await _fetchIpGeolocation();

    // 2. Fetch weather data using coordinates from IP
    final weatherData = await _fetchWeatherData(
      latitude: ipData['lat'],
      longitude: ipData['lon'],
    );

    // 3. (Optional) Get readable address using reverse geocoding
    //    Coordinates from IP are usually accurate enough for city level.
    final addressData = await _fetchReadableAddress(
      latitude: ipData['lat'],
      longitude: ipData['lon'],
    );

    final Map<String, dynamic> current = weatherData['current'] is Map
        ? Map<String, dynamic>.from(weatherData['current'])
        : {};

    // Use IP data as fallback if reverse geocoding fails
    final landmarkOrCircle = addressData['locality'] ??
        addressData['principalSubdivision'] ??
        ipData['city'] ??
        'Unknown place';

    final area = addressData['locality'] ??
        addressData['city'] ??
        ipData['city'] ??
        'Unknown area';

    final city = addressData['city'] ??
        addressData['locality'] ??
        ipData['city'] ??
        'Unknown city';

    final state = addressData['principalSubdivision'] ??
        ipData['region'] ??
        'Unknown state';

    final country =
        addressData['countryName'] ?? ipData['country'] ?? 'Unknown country';

    final fullAddress = [
      addressData['locality'],
      addressData['city'],
      addressData['principalSubdivision'],
      addressData['countryName'],
      ipData['city'],
      ipData['region'],
      ipData['country'],
    ].where((e) => e != null && e.toString().isNotEmpty).join(', ');

    final localTime = _cleanDateTimeText(current['time'] ?? '');

    return StartupInfo(
      landmarkOrCircle: landmarkOrCircle,
      area: area,
      city: city,
      state: state,
      country: country,
      fullAddress: fullAddress.isEmpty ? 'Unknown location' : fullAddress,
      timezone: weatherData['timezone'] ?? 'Unknown',
      timezoneAbbreviation: weatherData['timezone_abbreviation'] ?? '',
      localTime: localTime,
      isDay: ((current['is_day'] ?? 0) as num).toInt() == 1,
      temperature: (current['temperature_2m'] ?? '').toString(),
    );
  }

  /// Get location from IP address (free, no API key, no permission)
  Future<Map<String, dynamic>> _fetchIpGeolocation() async {
    // Using ip-api.com (free for non-commercial use, rate limited to 45 req/min)
    final uri = Uri.parse('http://ip-api.com/json/');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('IP geolocation failed: ${response.statusCode}');
    }
    final data = jsonDecode(response.body);
    if (data['status'] != 'success') {
      throw Exception('IP geolocation error: ${data['message']}');
    }
    return {
      'lat': data['lat'],
      'lon': data['lon'],
      'city': data['city'],
      'region': data['regionName'],
      'country': data['country'],
    };
  }

  /// Open‑Meteo weather (same as before)
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
      throw Exception('Weather API error: ${response.statusCode}');
    }
    return jsonDecode(response.body);
  }

  /// Reverse geocoding (BigDataCloud) – still uses coordinates from IP, no permission
  Future<Map<String, dynamic>> _fetchReadableAddress({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      'https://api.bigdatacloud.net/data/reverse-geocode-client'
      '?latitude=$latitude&longitude=$longitude&localityLanguage=en',
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      // Non‑critical, return empty map so fallback to IP data works
      return {};
    }
    return jsonDecode(response.body);
  }

  String _cleanDateTimeText(String value) {
    if (value.isEmpty) return 'Unknown';
    return value.replaceFirst('T', ' ');
  }
}
