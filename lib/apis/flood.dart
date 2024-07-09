// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../enums/daily.dart';
import '../enums/prefcls.dart';
import '../utils.dart';

/// Simulated river discharge at 5 km resolution from 1984 up to 7 months forecast.
///
/// https://open-meteo.com/en/docs/flood-api/
class Flood {
  /// Custom API URL, format: `https://<domain>/<version>/`.
  String? apiUrl = "https://flood-api.open-meteo.com/v1/";

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final double latitude, longitude;

  /// If `past_days` is set, past weather data can be returned.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  int? past_days;

  /// Per default, only 92 days are returned. Up to 210 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  int? forecast_days;

  /// The time interval to get data. Data are available from 1984-01-01 until 7 month forecast.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  DateTime? start_date, end_date;

  /// If `true`, all forecast ensemble members will be returned.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  bool? ensemble;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  CellSelection? cell_selection;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  String? apikey;

  Flood({
    this.apiUrl,
    required this.latitude,
    required this.longitude,
    this.past_days,
    this.forecast_days,
    this.start_date,
    this.end_date,
    this.cell_selection,
    this.apikey,
  }) {
    apiUrl = apiUrl ?? "https://flood-api.open-meteo.com/v1/";
    Uri.parse(apiUrl!);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> raw_request({List<Daily>? daily}) async {
    // ignore: prefer_interpolation_to_compose_strings
    String args = generateArgsDHCBase(daily, null, null) +
        createNullableParam("past_days", past_days) +
        createNullableParam("forecast_days", forecast_days) +
        createNullableParam(
            "start_date", start_date?.toIso8601String().substring(0, 10)) +
        createNullableParam(
            "end_date", end_date?.toIso8601String().substring(0, 10)) +
        createNullableParam("ensemble", ensemble) +
        createNullableParam("cell_selection", cell_selection) +
        createNullableParam("apikey", apikey);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}flood?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
