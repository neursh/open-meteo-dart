// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'hourly.dart';
import 'daily.dart';
import 'prefcls.dart';

export 'hourly.dart';
export 'daily.dart';
export 'prefcls.dart';
export 'geocoding.dart';

class InvalidDataException implements Exception {
  String cause;
  InvalidDataException(this.cause);
}

class OpenMeteo {
  /// Main class for checking and sending request to OpenMeteo's API.
  ///
  /// | attributes         | type               |
  /// |--------------------|--------------------|
  /// | latitude           | double             |
  /// | longitude          | double             |
  /// | current_weather    | bool?              |
  /// | temperature_unit   | TemperatureUnit?   |
  /// | windspeed_unit     | WindspeedUnit?     |
  /// | precipitation_unit | PrecipitationUnit? |
  /// | past_days          | int?               |
  /// | start_date         | DateTime?          |
  /// | end_date           | DateTime?          |
  ///
  /// To learn more about what are these attributes mean, go to [OpenMeteo's docs](https://open-meteo.com/en/docs).
  ///
  /// Example:
  /// ```
  /// var op = OpenMeteo(latitude: 52.52, longitude: 13.41);
  /// var hourly = Hourly(temperature_2m: true);
  /// var res = await op.raw_request(hourly: hourly);
  /// ```
  final double latitude, longitude;
  bool? current_weather = false;
  TemperatureUnit? temperature_unit = TemperatureUnit.celsius;
  WindspeedUnit? windspeed_unit = WindspeedUnit.kmh;
  PrecipitationUnit? precipitation_unit = PrecipitationUnit.mm;
  int? past_days;
  DateTime? start_date, end_date;

  OpenMeteo(
      {required this.latitude,
      required this.longitude,
      this.current_weather,
      this.temperature_unit,
      this.windspeed_unit,
      this.precipitation_unit,
      this.past_days,
      this.start_date,
      this.end_date}) {
    if (latitude < -90 || latitude > 90) {
      throw InvalidDataException(
          "Provided latitude must be in range -90 to 90");
    }
    if (longitude < -180 || longitude > 180) {
      throw InvalidDataException(
          "Provided longitude must be in range -180 to 180");
    }
  }

  Future<Map<String, dynamic>> raw_request(
      {List<Hourly>? hourly, List<Daily>? daily}) async {
    List<String> hourlyArgs = [], dailyArgs = [];

    if (hourly != null) {
      if (hourly.contains(Hourly.all)) {
        hourlyArgs = Hourly.values.map((value) => value.name).toList();
      } else {
        hourlyArgs = hourly.map((value) => value.name).toList();
      }
    }

    if (daily != null) {
      if (daily.contains(Daily.all)) {
        dailyArgs = Daily.values.map((value) => value.name).toList();
      } else {
        dailyArgs = daily.map((value) => value.name).toList();
      }
    }

    // Making sure there're no custom arguments from the client.
    hourlyArgs.remove("all");
    dailyArgs.remove("all");

    String args = "";
    args += hourlyArgs.isNotEmpty ? "hourly=${hourlyArgs.join(",")}" : "";
    args += dailyArgs.isNotEmpty
        ? "${hourlyArgs.isNotEmpty ? "&" : ""}daily=${dailyArgs.join(",")}"
        : "";

    if (args.isEmpty) {
      throw InvalidDataException("Please provide Hourly class or Daily class.");
    }

    args +=
        "${current_weather != null ? "&current_weather=$current_weather" : ""}${temperature_unit != null ? "&temperature_unit=${temperature_unit?.type}" : ""}${windspeed_unit != null ? "&windspeed_unit=${windspeed_unit!.type}" : ""}${precipitation_unit != null ? "&precipitation_unit=${precipitation_unit!.type}" : ""}${past_days != null ? "&past_days=$past_days" : ""}${start_date != null ? "&start_date=${start_date!.toIso8601String().substring(0, 9)}" : ""}${end_date != null ? "&end_date=${end_date!.toIso8601String().substring(0, 9)}" : ""}";

    var collected = jsonDecode((await http.get(Uri.parse(
            "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);

    return collected;
  }
}
