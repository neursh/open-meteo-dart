// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../enums/prefcls.dart';
import '../utils.dart';
import '../enums/daily.dart';
import '../enums/hourly.dart';

class Historical {
  String? apiUrl = "https://api.open-meteo.com/v1/";
  final double latitude, longitude;
  double? elevation;
  DateTime? start_date, end_date;
  TemperatureUnit? temperature_unit = TemperatureUnit.celsius;
  WindspeedUnit? windspeed_unit = WindspeedUnit.kmh;
  PrecipitationUnit? precipitation_unit = PrecipitationUnit.mm;
  CellSelection? cell_selection = CellSelection.land;
  String? apikey;

  Historical(
      {this.apiUrl,
      required this.latitude,
      required this.longitude,
      this.elevation,
      this.start_date,
      this.end_date,
      this.temperature_unit,
      this.windspeed_unit,
      this.precipitation_unit,
      this.apikey}) {
    apiUrl = apiUrl ?? "https://archive-api.open-meteo.com/v1/";
    Uri.parse(apiUrl!);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> raw_request(
      {List<Hourly>? hourly, List<Daily>? daily}) async {
    String args = generateArgsDHBase(hourly, daily) +
        createNullableParam("elevation", elevation) +
        createNullableParam(
            "start_date", start_date?.toIso8601String().split("T")[0]) +
        createNullableParam(
            "end_date", end_date?.toIso8601String().split("T")[0]) +
        createNullableParam("temperature_unit", temperature_unit) +
        createNullableParam("windspeed_unit", windspeed_unit) +
        createNullableParam("precipitation_unit", precipitation_unit) +
        createNullableParam("cell_selection", cell_selection) +
        createNullableParam("apikey", apikey);

    print(args);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}archive?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
