// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_meteo/enums/climate_model.dart';

import '../enums/prefcls.dart';
import '../utils.dart';
import '../enums/daily.dart';

/// Explore Climate Change on a Local Level with High-Resolution Climate Data
///
/// https://open-meteo.com/en/docs/climate-api/
class Climate {
  /// Custom API URL, format: `https://<domain>/<version>/`.
  String? apiUrl = "https://climate-api.open-meteo.com/v1/";

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final double latitude, longitude;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  DateTime start_date, end_date;

  /// If `TemperatureUnit.fahrenheit` is set, all temperature values are converted to Fahrenheit.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  TemperatureUnit? temperature_unit;

  /// Other wind speed speed units: `WindspeedUnit.ms`, `WindspeedUnit.mph` and `WindspeedUnit.kn`.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  WindspeedUnit? windspeed_unit;

  /// Other precipitation amount units: `PrecipitationUnit.inch`
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  PrecipitationUnit? precipitation_unit;

  /// Setting disable_bias_correction to true disables statistical downscaling
  /// and bias correction onto ERA5-Land. By default, all data is corrected
  /// using linear bias correction, and coefficients have been calculated for
  /// each month over a 50-year time series. The climate change signal is
  /// not affected by linear bias correction.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  bool? disable_bias_correction;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  CellSelection? cell_selection;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
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

  /// Create a HTTP request. The function will return JSON data as Map if successful.
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
