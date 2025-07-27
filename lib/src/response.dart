import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart';

import 'api.dart';
import 'weather_api_openmeteo_sdk_generated.dart';

class ApiResponse<Api extends BaseApi> {
  final Uri urlUsed;
  final double latitude;
  final double longitude;
  final double elevation;
  final Duration generationTime;
  final Duration utcOffset;
  final String? timezone;
  final String? timezoneAbbreviation;
  final Map<Parameter<Api, Minutely15>, ParameterValues> minutely15Data;
  final Map<Parameter<Api, Current>, ParameterValue> currentData;
  final Map<Parameter<Api, Hourly>, ParameterValues> hourlyData;
  final Map<Parameter<Api, Daily>, ParameterValues> dailyData;

  const ApiResponse._({
    required this.urlUsed,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.generationTime,
    required this.utcOffset,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.minutely15Data,
    required this.currentData,
    required this.hourlyData,
    required this.dailyData,
  });

  factory ApiResponse.fromFlatBuffer(
    Uri urlUsed,
    Uint8List bytes, {
    Map<int, Parameter<Api, Minutely15>>? minutely15Hashes,
    Map<int, Parameter<Api, Current>>? currentHashes,
    Map<int, Parameter<Api, Hourly>>? hourlyHashes,
    Map<int, Parameter<Api, Daily>>? dailyHashes,
  }) {
    int prefixed =
        BufferContext.fromBytes(bytes).buffer.getUint32(0, Endian.little);
    WeatherApiResponse response =
        WeatherApiResponse(bytes.sublist(4, prefixed + 4));

    return ApiResponse._(
      urlUsed: urlUsed,
      latitude: response.latitude,
      longitude: response.longitude,
      elevation: response.elevation,
      generationTime: Duration(
        microseconds: (response.generationTimeMilliseconds * 1000).round(),
      ),
      utcOffset: Duration(seconds: response.utcOffsetSeconds),
      timezone: response.timezone,
      timezoneAbbreviation: response.timezoneAbbreviation,
      minutely15Data:
          _deserializeMultiple(response.minutely15, minutely15Hashes),
      currentData: _deserializeSingle(response.current, currentHashes),
      hourlyData: _deserializeMultiple(response.hourly, hourlyHashes),
      dailyData: _deserializeMultiple(response.daily, dailyHashes),
    );
  }
}

class ParameterValue {
  final String unit;
  final DateTime time;
  final double value;

  const ParameterValue._({
    required this.unit,
    required this.time,
    required this.value,
  });
}

class ParameterValues {
  final String unit;
  final Map<DateTime, num> values;

  const ParameterValues._({
    required this.unit,
    required this.values,
  });
}

int _computeHash(VariableWithValues v) => computeHash(
      variable: v.variable,
      altitude: v.altitude,
      aggregation: v.aggregation,
      pressureLevel: v.pressureLevel,
      depth: v.depth,
      depthTo: v.depthTo,
    );

Map<ApiParameter, ParameterValue> _deserializeSingle<ApiParameter>(
  VariablesWithTime? data,
  Map<int, ApiParameter>? hashes,
) {
  if (data == null || hashes == null) return {};
  List<VariableWithValues>? variables = data.variables;
  if (variables == null) return {};

  DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(data.time * 1000);

  return Map.fromEntries(variables.map((v) {
    ApiParameter? parameter = hashes[_computeHash(v)];
    if (parameter == null) return null;

    return MapEntry(
      parameter,
      ParameterValue._(
        unit: _unitsMap[v.unit]!,
        time: timestamp,
        value: v.value,
      ),
    );
  }).nonNulls);
}

Map<ApiParameter, ParameterValues> _deserializeMultiple<ApiParameter>(
  VariablesWithTime? data,
  Map<int, ApiParameter>? hashes,
) {
  if (data == null || hashes == null) return {};
  List<VariableWithValues>? variables = data.variables;
  if (variables == null) return {};

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
    ApiParameter? parameter = hashes[_computeHash(v)];
    if (parameter == null) return null;

    return MapEntry(
      parameter,
      ParameterValues._(
        unit: _unitsMap[v.unit] ?? "",
        values: (v.values ?? v.valuesInt64)
                ?.asMap()
                .map((index, value) => MapEntry(timestamps[index], value)) ??
            {},
      ),
    );
  }).nonNulls);
}

const Map<Unit, String> _unitsMap = {
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
