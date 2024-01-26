// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_meteo/utils.dart';

import '../enums/current.dart';
import '../enums/daily.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';

class Marine {
  String? apiUrl = "https://marine-api.open-meteo.com/v1/";
  final double latitude, longitude;
  TemperatureUnit? temperature_unit;
  WindspeedUnit? windspeed_unit;
  PrecipitationUnit? precipitation_unit;
  int? past_days;
  int? forecast_days, forecast_hours, past_hours;
  DateTime? start_date, end_date;
  DateTime? start_hour, end_hour;
  LengthUnit? length_unit;
  String? cell_selection;
  String? apikey;

  Marine({
    this.apiUrl,
    required this.latitude,
    required this.longitude,
    this.temperature_unit,
    this.windspeed_unit,
    this.precipitation_unit,
    this.past_days,
    this.forecast_days,
    this.forecast_hours,
    this.past_hours,
    this.start_date,
    this.end_date,
    this.start_hour,
    this.end_hour,
    this.length_unit,
    this.cell_selection,
    this.apikey,
  }) {
    apiUrl = apiUrl ?? "https://marine-api.open-meteo.com/v1/";
    Uri.parse(apiUrl!);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> raw_request(
      {List<Hourly>? hourly,
      List<Daily>? daily,
      List<Current>? current}) async {
    String args = generateArgsDHCBase(daily, hourly, current) +
        createNullableParam('temperature_unit', temperature_unit?.name) +
        createNullableParam('windspeed_unit', windspeed_unit?.name) +
        createNullableParam('precipitation_unit', precipitation_unit?.name) +
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
        createNullableParam('length_unit', length_unit) +
        createNullableParam('cell_selection', cell_selection) +
        createNullableParam('apikey', apikey);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}marine?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
