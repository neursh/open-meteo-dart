import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart';

import '/enums/current.dart';
import '/enums/daily.dart';
import '/enums/hourly.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

class WeatherResponse {
  final double latitude;
  final double longitude;
  final double elevation;
  final Duration generationTime;
  final Duration utcOffset;
  final String? timezone;
  final String? timezoneAbbreviation;
  final Map<Current, WeatherParameterData>? currentWeatherData;
  final Map<Hourly, WeatherParameterData>? hourlyWeatherData;
  final Map<Daily, WeatherParameterData>? dailyWeatherData;

  const WeatherResponse._({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.generationTime,
    required this.utcOffset,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.currentWeatherData,
    required this.hourlyWeatherData,
    required this.dailyWeatherData,
  });

  factory WeatherResponse.fromFlatBuffer(Uint8List bytes) {
    int prefixed =
        BufferContext.fromBytes(bytes).buffer.getUint32(0, Endian.little);
    WeatherApiResponse response =
        WeatherApiResponse(bytes.sublist(4, prefixed + 4));

    return WeatherResponse._(
      latitude: response.latitude,
      longitude: response.longitude,
      elevation: response.elevation,
      generationTime: Duration(
        microseconds: (response.generationTimeMilliseconds * 1000).round(),
      ),
      utcOffset: Duration(seconds: response.utcOffsetSeconds),
      timezone: response.timezone,
      timezoneAbbreviation: response.timezoneAbbreviation,
      currentWeatherData: processSingle(response.current, Current.fromVariable),
      hourlyWeatherData: processMultiple(response.hourly, Hourly.fromVariable),
      dailyWeatherData: processMultiple(response.daily, Daily.fromVariable),
    );
  }
}

class WeatherParameterData {
  final String? unit;
  final Map<DateTime, double>? data;

  WeatherParameterData._({
    required this.unit,
    required this.data,
  });
}

Map<Parameter, WeatherParameterData>? processSingle<Parameter extends Enum>(
  VariablesWithTime? data,
  Parameter? Function(VariableWithValues) converter,
) {
  if (data == null) return null;
  List<VariableWithValues>? variables = data.variables;
  if (variables == null) return null;

  DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(data.time * 1000);

  return Map.fromEntries(variables.map((v) {
    Parameter? variable = converter(v);
    if (variable == null) return null;

    return MapEntry(
      variable,
      WeatherParameterData._(
        unit: unitsMap[v.unit],
        data: {timestamp: v.value},
      ),
    );
  }).nonNulls);
}

Map<Parameter, WeatherParameterData>? processMultiple<Parameter extends Enum>(
  VariablesWithTime? data,
  Parameter? Function(VariableWithValues) converter,
) {
  if (data == null) return null;
  List<VariableWithValues>? variables = data.variables;
  if (variables == null) return null;

  DateTime startTime = DateTime.fromMillisecondsSinceEpoch(data.time * 1000);
  DateTime endTime = DateTime.fromMillisecondsSinceEpoch(data.timeEnd * 1000);
  Duration interval = Duration(seconds: data.interval);
  List<DateTime> timestamps = [
    for (DateTime time = startTime;
        time.isBefore(endTime);
        time = time.add(interval))
      time
  ];

  return Map.fromEntries(variables.map((v) {
    Parameter? variable = converter(v);
    if (variable == null) return null;
    List<double>? values = v.values;
    if (values == null || values.nonNulls.isEmpty) return null;

    return MapEntry(
      variable,
      WeatherParameterData._(
        unit: unitsMap[v.unit],
        data: {
          for (int i = 0; i < timestamps.length && i < values.length; i++)
            timestamps[i]: values[i]
        },
      ),
    );
  }).nonNulls);
}

const Map<Unit, String> unitsMap = {
  Unit.undefined: '',
  Unit.celsius: '°C',
  Unit.centimetre: 'cm',
  Unit.cubic_metre_per_cubic_metre: 'm³/m³',
  Unit.cubic_metre_per_second: 'm³/s',
  Unit.degree_direction: '°',
  Unit.dimensionless_integer: '',
  Unit.dimensionless: '',
  Unit.european_air_quality_index: 'AQI',
  Unit.fahrenheit: '°F',
  Unit.feet: 'ft',
  Unit.fraction: '',
  Unit.gdd_celsius: '°C GDD',
  Unit.geopotential_metre: 'm',
  Unit.grains_per_cubic_metre: 'grains/m³',
  Unit.gram_per_kilogram: 'g/kg',
  Unit.hectopascal: 'hPa',
  Unit.hours: 'hr',
  Unit.inch: 'in',
  Unit.iso8601: '',
  Unit.joule_per_kilogram: 'J/kg',
  Unit.kelvin: 'kelvins',
  Unit.kilopascal: 'kPa',
  Unit.kilogram_per_square_metre: 'kg/m²',
  Unit.kilometres_per_hour: 'km/h',
  Unit.knots: 'kn',
  Unit.megajoule_per_square_metre: 'MJ/m²',
  Unit.metre_per_second_not_unit_converted: 'm/s',
  Unit.metre_per_second: 'm/s',
  Unit.metre: 'm',
  Unit.micrograms_per_cubic_metre: 'mcg/m³',
  Unit.miles_per_hour: 'mph',
  Unit.millimetre: 'mm',
  Unit.pascal: 'Pa',
  Unit.per_second: 'Hz',
  Unit.percentage: '%',
  Unit.seconds: 's',
  Unit.unix_time: 's',
  Unit.us_air_quality_index: 'AQI',
  Unit.watt_per_square_metre: 'W/m²',
  Unit.wmo_code: '',
};
