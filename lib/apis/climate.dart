// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_meteo/enums/climate_model.dart';

import '../enums/prefcls.dart';
import '../utils.dart';
import '../enums/daily.dart';

class Climate {
  String? apiUrl = "https://climate-api.open-meteo.com/v1/";
  final double latitude, longitude;
  DateTime start_date, end_date;
  TemperatureUnit? temperature_unit;
  WindspeedUnit? windspeed_unit;
  PrecipitationUnit? precipitation_unit;
  bool? disable_bias_correction;
  CellSelection? cell_selection;
  String? apikey;

  Climate(
      {this.apiUrl,
      required this.latitude,
      required this.longitude,
      required this.start_date,
      required this.end_date,
      this.temperature_unit,
      this.windspeed_unit,
      this.precipitation_unit,
      this.disable_bias_correction,
      this.cell_selection,
      this.apikey}) {
    apiUrl = apiUrl ?? "https://climate-api.open-meteo.com/v1/";
    Uri.parse(apiUrl!);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> raw_request(
      {required List<Daily> daily, required List<ClimateModel> models}) async {
    String args =
        // ignore: prefer_interpolation_to_compose_strings
        "models=${generateVaules(models).join(",")}&daily=${generateVaules(daily).join(",")}" +
            createNullableParam(
                "start_date", start_date.toIso8601String().split("T")[0]) +
            createNullableParam(
                "end_date", end_date.toIso8601String().split("T")[0]) +
            createNullableParam("temperature_unit", temperature_unit?.name) +
            createNullableParam("windspeed_unit", windspeed_unit?.name) +
            createNullableParam(
                "precipitation_unit", precipitation_unit?.name) +
            createNullableParam(
                "disable_bias_correction", disable_bias_correction) +
            createNullableParam("cell_selection", cell_selection) +
            createNullableParam("apikey", apikey);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}climate?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
