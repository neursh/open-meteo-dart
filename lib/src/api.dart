import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import './options.dart';

import 'exceptions.dart';
import 'weather_api_openmeteo_sdk_generated.dart';

mixin Parameter<Api extends BaseApi, Time extends TimeType> on Enum {
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

Map<int, ApiParameter> makeHashes<ApiParameter extends Parameter>(
  Iterable<ApiParameter> values,
) =>
    {for (final val in values) val.hash: val};

sealed class TimeType {}

final class Minutely15 extends TimeType {}

final class Current extends TimeType {}

final class Hourly extends TimeType {}

final class Daily extends TimeType {}

abstract class BaseApi {
  static final Finalizer<int> _finalizer = Finalizer((hashCode) {
    _clients[hashCode]?.close();
    _clients.remove(hashCode);
  });

  final String apiUrl;
  final String apiKey;
  final String userAgent;

  http.Client get _client => _clients.putIfAbsent(hashCode, () {
        _finalizer.attach(this, hashCode);
        return http.Client();
      });

  const BaseApi({
    required this.apiUrl,
    this.apiKey = '',
    this.userAgent =
        'Open-meteo-dart | https://github.com/neursh/open-meteo-dart',
  });
}

final Map<int, http.Client> _clients = {};

Future<Map<String, dynamic>> apiRequestJson(
  BaseApi api,
  Map<String, dynamic> queryParams,
  Uri Function(Uri)? overrideUri,
) async {
  Uri url = Uri.parse(api.apiUrl).replace(
    query: _encodeQuery(queryParams, {
      'apikey': nullIfEqual(api.apiKey, ''),
    }),
  );

  if (overrideUri != null) {
    url = overrideUri(url);
  }

  return jsonDecode(
    (await api._client.get(url, headers: {"User-Agent": api.userAgent})).body,
  );
}

Future<(Uri, Uint8List)> apiRequestFlatBuffer(
  BaseApi api,
  Map<String, dynamic> queryParams,
  Uri Function(Uri)? overrideUri,
) async {
  Uri url = Uri.parse(api.apiUrl).replace(
    query: _encodeQuery(queryParams, {
      'apikey': nullIfEqual(api.apiKey, ''),
      'format': 'flatbuffers',
    }),
  );

  if (overrideUri != null) {
    url = overrideUri(url);
  }

  http.Response response =
      await api._client.get(url, headers: {"User-Agent": api.userAgent});
  if (response.statusCode != 200) {
    throw OpenMeteoApiError(jsonDecode(response.body)['reason']);
  }

  return (url, response.bodyBytes);
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

String? formatDate(DateTime? date) => date?.toIso8601String().substring(0, 10);
String? formatTime(DateTime? time) => time?.toIso8601String();

T? nullIfEqual<T>(T value, T defaultValue) =>
    value == defaultValue ? null : value;

T? nullIfEmpty<T extends Iterable>(T iterable) =>
    iterable.isEmpty ? null : iterable;

class ParsedLocations {
  final List<double> latitude;
  final List<double> longitude;
  final List<double> elevation;
  final List<String> startDate;
  final List<String> endDate;

  const ParsedLocations({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.startDate,
    required this.endDate,
  });
}

ParsedLocations parseLocations(Set<OpenMeteoLocation> locations) {
  List<double> latitude = [];
  List<double> longitude = [];
  List<double> elevation = [];
  List<String> startDate = [];
  List<String> endDate = [];

  for (final location in locations) {
    latitude.add(location.latitude);
    longitude.add(location.longitude);
    if (location.elevation != null) {
      elevation.add(location.elevation!);
    }
    if (location.startDate != null) {
      startDate.add(formatDate(location.startDate)!);
    }
    if (location.endDate != null) {
      endDate.add(formatDate(location.endDate)!);
    }
  }

  checkMalformed(List<dynamic> childList) {
    return childList.isNotEmpty && childList.length != locations.length;
  }

  if (checkMalformed(elevation) ||
      checkMalformed(startDate) ||
      checkMalformed(endDate)) {
    throw OpenMeteoApiError(
      "Optional parameters must have the same number of elements as coordinates.",
    );
  }

  return ParsedLocations(
    latitude: latitude,
    longitude: longitude,
    elevation: elevation,
    startDate: startDate,
    endDate: endDate,
  );
}
