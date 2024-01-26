// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../enums/daily.dart';
import '../enums/prefcls.dart';
import '../utils.dart';

class Flood {
  String? apiUrl = "https://flood-api.open-meteo.com/v1/";
  final double latitude, longitude;
  double? elevation;
  int? past_days;
  int? forecast_days;
  DateTime? start_date, end_date;
  bool? ensemble;
  CellSelection? cell_selection;
  String? apikey;

  Flood({
    this.apiUrl,
    required this.latitude,
    required this.longitude,
    this.elevation,
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

  Future<Map<String, dynamic>> raw_request({List<Daily>? daily}) async {
    // ignore: prefer_interpolation_to_compose_strings
    String args = generateArgsDHCBase(daily, null, null) +
        createNullableParam('elevation', elevation) +
        createNullableParam('past_days', past_days) +
        createNullableParam('forecast_days', forecast_days) +
        createNullableParam(
            'start_date', start_date?.toIso8601String().substring(0, 10)) +
        createNullableParam(
            'end_date', end_date?.toIso8601String().substring(0, 10)) +
        createNullableParam('ensemble', ensemble) +
        createNullableParam('cell_selection', cell_selection) +
        createNullableParam('apikey', apikey);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}flood?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
