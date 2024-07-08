// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '/enums/current.dart';
import '/enums/daily.dart';
import '/enums/hourly.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
sealed class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse.error({
    required bool error,
    required String reason,
  }) = WeatherError;

  const factory WeatherResponse.data({
    required num latitude,
    required num longitude,
    required num elevation,
    @JsonKey(name: 'generationtime_ms') required num generationTimeMs,
    @JsonKey(name: 'utc_offset_seconds', fromJson: _convertDuration)
    required Duration utcOffset,
    required String timezone,
    @JsonKey(name: 'timezone_abbreviation')
    required String timezoneAbbreviation,
    @JsonKey(name: 'current_units', defaultValue: {})
    required Map<Current, String> currentWeatherUnits,
    @JsonKey(name: 'current', defaultValue: {})
    required Map<Current, num?> currentWeatherData,
    @JsonKey(name: 'hourly_units', defaultValue: {})
    required Map<Hourly, String> hourlyForecastUnits,
    @JsonKey(name: 'hourly', defaultValue: {})
    required Map<Hourly, List<num?>> hourlyForecastData,
    @JsonKey(name: 'daily_units', defaultValue: {})
    required Map<Daily, String> dailyForecastUnits,
    @JsonKey(name: 'daily', defaultValue: {})
    required Map<Daily, List<num?>> dailyForecastData,
    required DateTime? currentWeatherTime,
    @JsonKey(defaultValue: []) required List<DateTime> hourlyForecastTimes,
    @JsonKey(defaultValue: []) required List<DateTime> dailyForecastTimes,
  }) = WeatherData;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      json.containsKey('error')
          ? WeatherError.fromJson(json)
          // Preprocess before parsing
          : _weatherDataFromJson(json);
}

WeatherData _weatherDataFromJson(Map<String, dynamic> json) {
  if (json.containsKey('current')) {
    json['currentWeatherTime'] = _convertTime(json['current']['time']);
    json['current'] as Map<String, dynamic>
      ..remove('time')
      ..remove('interval');
    json['current_units'] as Map<String, dynamic>
      ..remove('time')
      ..remove('interval');
  }

  if (json.containsKey('hourly')) {
    json['hourlyForecastTime'] =
        (json['hourly']['time'] as List<dynamic>).map(_convertTime).toList();
    json['hourly'] as Map<String, dynamic>..remove('time');
    json['hourly_units'] as Map<String, dynamic>..remove('time');
  }

  if (json.containsKey('daily')) {
    json['dailyForecastTime'] =
        (json['daily']['time'] as List<dynamic>).map(_convertTime).toList();
    json['daily'] as Map<String, dynamic>..remove('time');
    json['daily_units'] as Map<String, dynamic>..remove('time');
  }

  return WeatherData.fromJson(json);
}

Duration _convertDuration(int seconds) => Duration(seconds: seconds);

String _convertTime(dynamic json) => switch (json) {
      num unixSeconds =>
        DateTime.fromMillisecondsSinceEpoch(unixSeconds.toInt() * 1000)
            .toIso8601String(),
      String iso8601 => iso8601,
      _ => throw Exception('Illegal time value $json'),
    };
