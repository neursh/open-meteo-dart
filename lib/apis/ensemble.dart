// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../enums/ensemble_model.dart';
import '../enums/prefcls.dart';
import '../utils.dart';

class Ensemble {
  String? apiUrl = "https://ensemble-api.open-meteo.com/v1/";
  final double latitude, longitude;
  double? elevation;
  TemperatureUnit? temperature_unit;
  WindspeedUnit? windspeed_unit;
  PrecipitationUnit? precipitation_unit;
  int? past_days;
  int? forecast_days, forecast_hours, forecast_minutely_15;
  int? past_hours, past_minutely_15;
  DateTime? start_date, end_date;
  DateTime? start_hour, end_hour;
  DateTime? start_minutely_15, end_minutely_15;
  CellSelection? cell_selection;
  String? apikey;

  Ensemble({
    this.apiUrl,
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.temperature_unit,
    this.windspeed_unit,
    this.precipitation_unit,
    this.past_days,
    this.forecast_days,
    this.forecast_hours,
    this.forecast_minutely_15,
    this.past_hours,
    this.past_minutely_15,
    this.start_date,
    this.end_date,
    this.start_hour,
    this.end_hour,
    this.start_minutely_15,
    this.end_minutely_15,
    this.cell_selection,
    this.apikey,
  }) {
    apiUrl = apiUrl ?? "https://ensemble-api.open-meteo.com/v1/";
    Uri.parse(apiUrl!);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> raw_request(
      {required List<EnsembleModel> models}) async {
    // ignore: prefer_interpolation_to_compose_strings
    String args = "models=${generateVaules(models).join(",")}" +
        createNullableParam('elevation', elevation) +
        createNullableParam('temperature_unit', temperature_unit?.name) +
        createNullableParam('windspeed_unit', windspeed_unit?.name) +
        createNullableParam('precipitation_unit', precipitation_unit?.name) +
        createNullableParam('past_days', past_days) +
        createNullableParam('forecast_days', forecast_days) +
        createNullableParam('forecast_hours', forecast_hours) +
        createNullableParam('forecast_minutely_15', forecast_minutely_15) +
        createNullableParam('past_hours', past_hours) +
        createNullableParam('past_minutely_15', past_minutely_15) +
        createNullableParam(
            'start_date', start_date?.toIso8601String().substring(0, 10)) +
        createNullableParam(
            'end_date', end_date?.toIso8601String().substring(0, 10)) +
        createNullableParam('start_hour', start_hour?.toIso8601String()) +
        createNullableParam('end_hour', end_hour?.toIso8601String()) +
        createNullableParam(
            'start_minutely_15', start_minutely_15?.toIso8601String()) +
        createNullableParam(
            'end_minutely_15', end_minutely_15?.toIso8601String()) +
        createNullableParam('cell_selection', cell_selection) +
        createNullableParam('apikey', apikey);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}ensemble?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
