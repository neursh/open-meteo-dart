// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_meteo/enums/air_quality_domain.dart';
import 'package:open_meteo/utils.dart';

import '../enums/current.dart';
import '../enums/hourly.dart';

class AirQuality {
  String? apiUrl = "https://air-quality-api.open-meteo.com/v1/";
  final double latitude, longitude;
  AirQualityDomain? domains;
  int? past_days;
  int? forecast_days, forecast_hours, past_hours;
  DateTime? start_date, end_date;
  DateTime? start_hour, end_hour;
  String? cell_selection;
  String? apikey;

  AirQuality({
    this.apiUrl,
    required this.latitude,
    required this.longitude,
    this.domains,
    this.past_days,
    this.forecast_days,
    this.forecast_hours,
    this.past_hours,
    this.start_date,
    this.end_date,
    this.start_hour,
    this.end_hour,
    this.cell_selection,
    this.apikey,
  }) {
    apiUrl = apiUrl ?? "https://air-quality-api.open-meteo.com/v1/";
    Uri.parse(apiUrl!);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> raw_request(
      {List<Hourly>? hourly, List<Current>? current}) async {
    String args = generateArgsDHCBase(null, hourly, current) +
        createNullableParam('domains', domains?.name) +
        createNullableParam('past_days', past_days) +
        createNullableParam('forecast_days', forecast_days) +
        createNullableParam('forecast_hours', forecast_hours) +
        createNullableParam('past_hours', past_hours) +
        createNullableParam(
            'start_date', start_date?.toIso8601String().substring(0, 10)) +
        createNullableParam(
            'end_date', end_date?.toIso8601String().substring(0, 10)) +
        createNullableParam('start_hour', start_hour?.toIso8601String()) +
        createNullableParam('end_hour', end_hour?.toIso8601String()) +
        createNullableParam('cell_selection', cell_selection) +
        createNullableParam('apikey', apikey);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}air-quality?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
