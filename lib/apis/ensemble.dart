// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../enums/ensemble_model.dart';
import '../enums/prefcls.dart';
import '../utils.dart';

/// Hundreds Of Weather Forecasts, Every time, Everywhere, All at Once.
///
/// https://open-meteo.com/en/docs/ensemble-api/
class Ensemble {
  /// Custom API URL, format: `https://<domain>/<version>/`.
  String? apiUrl = "https://ensemble-api.open-meteo.com/v1/";

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final double latitude, longitude;

  /// The elevation used for statistical downscaling. Per default,
  /// a 90 meter digital elevation model is used.
  /// You can manually set the elevation to correctly match mountain peaks.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  double? elevation;

  /// If `TemperatureUnit.fahrenheit` is set, all temperature values are converted to Fahrenheit.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  TemperatureUnit? temperature_unit;

  ///Other wind speed speed units: `WindspeedUnit.ms`, `WindspeedUnit.mph` and `WindspeedUnit.kn`.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  WindspeedUnit? windspeed_unit;

  /// Other precipitation amount units: `PrecipitationUnit.inch`
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  PrecipitationUnit? precipitation_unit;

  /// If `past_days` is set, past weather data can be returned.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  int? past_days;

  /// Per default, only 7 days are returned. Up to 35 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  int? forecast_days;

  /// Similar to forecast_days, the number of timesteps of hourly and 15-minutely
  /// data can controlled. Instead of using the current day as a reference,
  /// the current hour or the current 15-minute time-step is used.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  int? forecast_hours, forecast_minutely_15;

  /// Similar to forecast_days, the number of timesteps of hourly and 15-minutely
  /// data can controlled. Instead of using the current day as a reference,
  /// the current hour or the current 15-minute time-step is used.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  int? past_hours, past_minutely_15;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  DateTime? start_date, end_date;

  /// The time interval to get weather data for hourly or 15 minutely data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  DateTime? start_hour, end_hour;

  /// The time interval to get weather data for hourly or 15 minutely data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  DateTime? start_minutely_15, end_minutely_15;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  CellSelection? cell_selection;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
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

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> raw_request(
      {required List<EnsembleModel> models}) async {
    // ignore: prefer_interpolation_to_compose_strings
    String args = "models=${generateVaules(models).join(",")}" +
        createNullableParam("elevation", elevation) +
        createNullableParam("temperature_unit", temperature_unit?.name) +
        createNullableParam("windspeed_unit", windspeed_unit?.name) +
        createNullableParam("precipitation_unit", precipitation_unit?.name) +
        createNullableParam("past_days", past_days) +
        createNullableParam("forecast_days", forecast_days) +
        createNullableParam("forecast_hours", forecast_hours) +
        createNullableParam("forecast_minutely_15", forecast_minutely_15) +
        createNullableParam("past_hours", past_hours) +
        createNullableParam("past_minutely_15", past_minutely_15) +
        createNullableParam(
            "start_date", start_date?.toIso8601String().substring(0, 10)) +
        createNullableParam(
            "end_date", end_date?.toIso8601String().substring(0, 10)) +
        createNullableParam("start_hour", start_hour?.toIso8601String()) +
        createNullableParam("end_hour", end_hour?.toIso8601String()) +
        createNullableParam(
            "start_minutely_15", start_minutely_15?.toIso8601String()) +
        createNullableParam(
            "end_minutely_15", end_minutely_15?.toIso8601String()) +
        createNullableParam("cell_selection", cell_selection) +
        createNullableParam("apikey", apikey);

    // Send the request.
    return jsonDecode((await http.get(Uri.parse(
            "${apiUrl}ensemble?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);
  }
}
