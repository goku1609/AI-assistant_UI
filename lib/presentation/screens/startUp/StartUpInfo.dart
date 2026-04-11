class StartupInfo {
  // Location
  final String landmarkOrCircle;
  final String area;
  final String city;
  final String state;
  final String country;
  final String fullAddress;

  // Time
  final String timezone;
  final String timezoneAbbreviation;
  final String localTime;

  // Weather
  final bool isDay;
  final String temperature;

  // Outfit suggestion
  String outfitSuggestion;

  StartupInfo({
    required this.landmarkOrCircle,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
    required this.fullAddress,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.localTime,
    required this.isDay,
    required this.temperature,
    this.outfitSuggestion = '',
  });

  String get dayNightText => isDay ? 'Day' : 'Night';

  String get weatherCondition {
    final temp = double.tryParse(temperature) ?? 25;

    if (isDay) {
      if (temp > 25) return 'Sunny';
      if (temp > 15) return 'Pleasant';
      return 'Cool';
    } else {
      if (temp > 20) return 'Warm Night';
      if (temp > 10) return 'Cool Night';
      return 'Cold Night';
    }
  }

  Map<String, dynamic> toJson() => {
        'landmarkOrCircle': landmarkOrCircle,
        'area': area,
        'city': city,
        'state': state,
        'country': country,
        'fullAddress': fullAddress,
        'timezone': timezone,
        'timezoneAbbreviation': timezoneAbbreviation,
        'localTime': localTime,
        'isDay': isDay,
        'temperature': temperature,
        'outfitSuggestion': outfitSuggestion,
      };

  factory StartupInfo.fromJson(Map<String, dynamic> json) {
    return StartupInfo(
      landmarkOrCircle: json['landmarkOrCircle'],
      area: json['area'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      fullAddress: json['fullAddress'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezoneAbbreviation'],
      localTime: json['localTime'],
      isDay: json['isDay'],
      temperature: json['temperature'],
      outfitSuggestion: json['outfitSuggestion'] ?? '',
    );
  }
}
