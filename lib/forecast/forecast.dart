// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../open_meteo.dart';

class Forecast {
  final double latitude, longitude;
  bool? current_weather = false;
  TemperatureUnit? temperature_unit = TemperatureUnit.celsius;
  WindspeedUnit? windspeed_unit = WindspeedUnit.kmh;
  PrecipitationUnit? precipitation_unit = PrecipitationUnit.mm;
  int? past_days;
  DateTime? start_date, end_date;

  Forecast(
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
    // Convert enums to standard parameters.
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

    // Making sure there're no custom parameters in request.
    hourlyArgs.remove("all");
    dailyArgs.remove("all");

    if (hourlyArgs.isEmpty && dailyArgs.isEmpty) {
      throw InvalidDataException(
          "Please provide at least one of the two Hourly or Daily enum parameters.");
    }

    // Put additional parameters built for Forecast API.
    String args = "";
    args += hourlyArgs.isNotEmpty ? "hourly=${hourlyArgs.join(",")}" : "";
    args += dailyArgs.isNotEmpty
        ? "${hourlyArgs.isNotEmpty ? "&" : ""}daily=${dailyArgs.join(",")}"
        : "";
    args += current_weather != null ? "&current_weather=$current_weather" : "";
    args += temperature_unit != null
        ? "&temperature_unit=${temperature_unit?.name}"
        : "";
    args +=
        windspeed_unit != null ? "&windspeed_unit=${windspeed_unit!.name}" : "";
    args += precipitation_unit != null
        ? "&precipitation_unit=${precipitation_unit!.name}"
        : "";
    args += past_days != null ? "&past_days=$past_days" : "";
    args += start_date != null
        ? "&start_date=${start_date!.toIso8601String().substring(0, 9)}"
        : "";
    args += end_date != null
        ? "&end_date=${end_date!.toIso8601String().substring(0, 9)}"
        : "";

    // Send the request.
    Map<String, dynamic> collected = jsonDecode((await http.get(Uri.parse(
            "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&$args&timeformat=unixtime&timezone=auto")))
        .body);

    return collected;
  }
}
