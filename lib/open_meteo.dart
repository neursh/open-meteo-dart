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
      {Hourly? hourly, Daily? daily}) async {
    List<String> hourlyArgs = [], dailyArgs = [];

    if (hourly != null) {
      if (hourly.all ?? false) {
        hourlyArgs = [
          "temperature_2m",
          "temperature_80m",
          "temperature_120m",
          "temperature_180m",
          "relativehumidity_2m",
          "dewpoint_2m",
          "apparent_temperature",
          "precipitation",
          "rain",
          "showers",
          "snowfall",
          "snow_depth",
          "freezinglevel_height",
          "weathercode",
          "pressure_msl",
          "surface_pressure",
          "cloudcover",
          "cloudcover_low",
          "cloudcover_mid",
          "cloudcover_high",
          "visibility",
          "evapotranspiration",
          "et0_fao_evapotranspiration",
          "vapor_pressure_deficit",
          "cape",
          "windspeed_10m",
          "windspeed_80m",
          "windspeed_120m",
          "windspeed_180m",
          "winddirection_10m",
          "winddirection_80m",
          "winddirection_120m",
          "winddirection_180m",
          "windgusts_10m",
          "soil_temperature_0cm",
          "soil_temperature_6cm",
          "soil_temperature_18cm",
          "soil_temperature_54cm",
          "soil_moisture_0_1cm",
          "soil_moisture_1_3cm",
          "soil_moisture_3_9cm",
          "soil_moisture_9_27cm",
          "soil_moisture_27_81cm"
        ];
      } else {
        if (hourly.temperature_2m ?? false) {
          hourlyArgs.add("temperature_2m");
        }
        if (hourly.temperature_80m ?? false) {
          hourlyArgs.add("temperature_80m");
        }
        if (hourly.temperature_120m ?? false) {
          hourlyArgs.add("temperature_120m");
        }
        if (hourly.temperature_180m ?? false) {
          hourlyArgs.add("temperature_180m");
        }
        if (hourly.relativehumidity_2m ?? false) {
          hourlyArgs.add("relativehumidity_2m");
        }
        if (hourly.dewpoint_2m ?? false) {
          hourlyArgs.add("dewpoint_2m");
        }
        if (hourly.apparent_temperature ?? false) {
          hourlyArgs.add("apparent_temperature");
        }
        if (hourly.precipitation ?? false) {
          hourlyArgs.add("precipitation");
        }
        if (hourly.rain ?? false) {
          hourlyArgs.add("rain");
        }
        if (hourly.showers ?? false) {
          hourlyArgs.add("showers");
        }
        if (hourly.snowfall ?? false) {
          hourlyArgs.add("snowfall");
        }
        if (hourly.snow_depth ?? false) {
          hourlyArgs.add("snow_depth");
        }
        if (hourly.freezinglevel_height ?? false) {
          hourlyArgs.add("freezinglevel_height");
        }
        if (hourly.weathercode ?? false) {
          hourlyArgs.add("weathercode");
        }
        if (hourly.pressure_msl ?? false) {
          hourlyArgs.add("pressure_msl");
        }
        if (hourly.surface_pressure ?? false) {
          hourlyArgs.add("surface_pressure");
        }
        if (hourly.cloudcover ?? false) {
          hourlyArgs.add("cloudcover");
        }
        if (hourly.cloudcover_low ?? false) {
          hourlyArgs.add("cloudcover_low");
        }
        if (hourly.cloudcover_mid ?? false) {
          hourlyArgs.add("cloudcover_mid");
        }
        if (hourly.cloudcover_high ?? false) {
          hourlyArgs.add("cloudcover_high");
        }
        if (hourly.visibility ?? false) {
          hourlyArgs.add("visibility");
        }
        if (hourly.evapotranspiration ?? false) {
          hourlyArgs.add("evapotranspiration");
        }
        if (hourly.et0_fao_evapotranspiration ?? false) {
          hourlyArgs.add("et0_fao_evapotranspiration");
        }
        if (hourly.vapor_pressure_deficit ?? false) {
          hourlyArgs.add("vapor_pressure_deficit");
        }
        if (hourly.cape ?? false) {
          hourlyArgs.add("cape");
        }
        if (hourly.windspeed_10m ?? false) {
          hourlyArgs.add("windspeed_10m");
        }
        if (hourly.windspeed_80m ?? false) {
          hourlyArgs.add("windspeed_80m");
        }
        if (hourly.windspeed_120m ?? false) {
          hourlyArgs.add("windspeed_120m");
        }
        if (hourly.windspeed_180m ?? false) {
          hourlyArgs.add("windspeed_180m");
        }
        if (hourly.winddirection_10m ?? false) {
          hourlyArgs.add("winddirection_10m");
        }
        if (hourly.winddirection_80m ?? false) {
          hourlyArgs.add("winddirection_80m");
        }
        if (hourly.winddirection_120m ?? false) {
          hourlyArgs.add("winddirection_120m");
        }
        if (hourly.winddirection_180m ?? false) {
          hourlyArgs.add("winddirection_180m");
        }
        if (hourly.windgusts_10m ?? false) {
          hourlyArgs.add("windgusts_10m");
        }
        if (hourly.soil_temperature_0cm ?? false) {
          hourlyArgs.add("soil_temperature_0cm");
        }
        if (hourly.soil_temperature_6cm ?? false) {
          hourlyArgs.add("soil_temperature_6cm");
        }
        if (hourly.soil_temperature_18cm ?? false) {
          hourlyArgs.add("soil_temperature_18cm");
        }
        if (hourly.soil_temperature_54cm ?? false) {
          hourlyArgs.add("soil_temperature_54cm");
        }
        if (hourly.soil_moisture_0_1cm ?? false) {
          hourlyArgs.add("soil_moisture_0_1cm");
        }
        if (hourly.soil_moisture_1_3cm ?? false) {
          hourlyArgs.add("soil_moisture_1_3cm");
        }
        if (hourly.soil_moisture_3_9cm ?? false) {
          hourlyArgs.add("soil_moisture_3_9cm");
        }
        if (hourly.soil_moisture_9_27cm ?? false) {
          hourlyArgs.add("soil_moisture_9_27cm");
        }
        if (hourly.soil_moisture_27_81cm ?? false) {
          hourlyArgs.add("soil_moisture_27_81cm");
        }
      }
    }

    if (daily != null) {
      if (daily.all ?? false) {
        dailyArgs = [
          "weathercode",
          "temperature_2m_max",
          "temperature_2m_min",
          "apparent_temperature_max",
          "apparent_temperature_min",
          "sunrise",
          "sunset",
          "precipitation_sum",
          "rain_sum",
          "showers_sum",
          "snowfall_sum",
          "precipitation_hours",
          "windspeed_10m_max",
          "windgusts_10m_max",
          "winddirection_10m_dominant",
          "shortwave_radiation_sum",
          "et0_fao_evapotranspiration"
        ];
      } else {
        if (daily.weathercode ?? false) {
          dailyArgs.add("weathercode");
        }
        if (daily.temperature_2m_max ?? false) {
          dailyArgs.add("temperature_2m_max");
        }
        if (daily.temperature_2m_min ?? false) {
          dailyArgs.add("temperature_2m_min");
        }
        if (daily.apparent_temperature_max ?? false) {
          dailyArgs.add("apparent_temperature_max");
        }
        if (daily.apparent_temperature_min ?? false) {
          dailyArgs.add("apparent_temperature_min");
        }
        if (daily.sunrise ?? false) {
          dailyArgs.add("sunrise");
        }
        if (daily.sunset ?? false) {
          dailyArgs.add("sunset");
        }
        if (daily.precipitation_sum ?? false) {
          dailyArgs.add("precipitation_sum");
        }
        if (daily.rain_sum ?? false) {
          dailyArgs.add("rain_sum");
        }
        if (daily.showers_sum ?? false) {
          dailyArgs.add("showers_sum");
        }
        if (daily.snowfall_sum ?? false) {
          dailyArgs.add("snowfall_sum");
        }
        if (daily.precipitation_hours ?? false) {
          dailyArgs.add("precipitation_hours");
        }
        if (daily.windspeed_10m_max ?? false) {
          dailyArgs.add("windspeed_10m_max");
        }
        if (daily.windgusts_10m_max ?? false) {
          dailyArgs.add("windgusts_10m_max");
        }
        if (daily.winddirection_10m_dominant ?? false) {
          dailyArgs.add("winddirection_10m_dominant");
        }
        if (daily.shortwave_radiation_sum ?? false) {
          dailyArgs.add("shortwave_radiation_sum");
        }
        if (daily.et0_fao_evapotranspiration ?? false) {
          dailyArgs.add("et0_fao_evapotranspiration");
        }
        if (daily.uv_index_max ?? false) {
          dailyArgs.add("daily.uv_index_max");
        }
        if (daily.uv_index_clear_sky_max ?? false) {
          dailyArgs.add("daily.uv_index_max");
        }
      }
    }

    String args = "";
    args += hourlyArgs.isNotEmpty ? "hourly=${hourlyArgs.join(",")}" : "";
    args += dailyArgs.isNotEmpty
        ? "${hourlyArgs.isNotEmpty ? "&" : ""}daily=${dailyArgs.join(",")}"
        : "";

    if (args == "") {
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
