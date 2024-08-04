import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'exceptions.dart';
import 'weather_api_openmeteo_sdk_generated.dart';

mixin WeatherParameter<Api extends BaseApi, Time extends TimeType> on Enum {
  Variable get variable;
  Aggregation get aggregation => Aggregation.none;
  int get altitude => 0;
  int get pressureLevel => 0;
  int get depth => 0;
  int get depthTo => 0;

  int get hash => computeHash(
        variable: variable,
        altitude: altitude,
        aggregation: aggregation,
        pressureLevel: pressureLevel,
        depth: depth,
        depthTo: depthTo,
      );
}

int computeHash({
  required Variable variable,
  required Aggregation aggregation,
  required int altitude,
  required int pressureLevel,
  required int depth,
  required int depthTo,
}) =>
    Object.hash(variable.value, aggregation.value, altitude, pressureLevel,
        depth, depthTo);

Map<int, ApiParameter> makeHashes<ApiParameter extends WeatherParameter>(
        List<ApiParameter> values) =>
    {for (final val in values) val.hash: val};

sealed class TimeType {}

final class Current extends TimeType {}

final class Hourly extends TimeType {}

final class Daily extends TimeType {}

class BaseApi {
  final String apiUrl;
  final String? apiKey;

  http.Client? _client;
  http.Client get client => (_client ??= http.Client());

  BaseApi({
    required this.apiUrl,
    required this.apiKey,
  });
}

Future<Map<String, dynamic>> requestJson(
  BaseApi api,
  Map<String, dynamic> queryParams,
) async {
  Uri url = Uri.parse(api.apiUrl).replace(
    query: _encodeQuery(queryParams, {
      if (api.apiKey != null) 'apikey': api.apiKey,
    }),
  );
  print(url.toString());
  return jsonDecode((await api.client.get(url)).body);
}

Future<Uint8List> requestFlatBuffer(
  BaseApi api,
  Map<String, dynamic> queryParams,
) async {
  Uri url = Uri.parse(api.apiUrl).replace(
    query: _encodeQuery(queryParams, {
      if (api.apiKey != null) 'apikey': api.apiKey,
      'format': 'flatbuffers',
    }),
  );

  http.Response response = await api.client.get(url);
  if (response.statusCode != 200) {
    throw OpenMeteoApiError(jsonDecode(response.body)['reason']);
  }

  return response.bodyBytes;
}

// Need this because Uri.encode... replaces commas
// with %2C, causing Open-Meteo to reject it
String _encodeQuery(
  Map<String, dynamic> queryParams, [
  Map<String, dynamic> overrides = const {},
]) =>
    queryParams.entries
        .followedBy(overrides.entries)
        .map(_convertQueryEntry)
        .nonNulls
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

MapEntry<String, String>? _convertQueryEntry(MapEntry<String, dynamic> entry) =>
    switch (entry.value) {
      null => null,
      Enum v => MapEntry(entry.key, v.name),
      Iterable<Enum> v => MapEntry(entry.key, v.map((e) => e.name).join(',')),
      Iterable<Object> v =>
        MapEntry(entry.key, v.map((e) => e.toString()).join(',')),
      Object v => MapEntry(entry.key, v.toString()),
    };
