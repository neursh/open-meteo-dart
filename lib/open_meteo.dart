// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

class InvalidDataException implements Exception {
  String cause;
  InvalidDataException(this.cause);
}

class Daily {
  /// A class to specify what you want out of the API for daily infomations.
  ///
  /// | attributes                 | type  |
  /// |----------------------------|-------|
  /// | weathercode                | bool? |
  /// | temperature_2m_max         | bool? |
  /// | temperature_2m_min         | bool? |
  /// | apparent_temperature_max   | bool? |
  /// | apparent_temperature_min   | bool? |
  /// | sunrise                    | bool? |
  /// | sunset                     | bool? |
  /// | precipitation_sum          | bool? |
  /// | rain_sum                   | bool? |
  /// | showers_sum                | bool? |
  /// | snowfall_sum               | bool? |
  /// | precipitation_hours        | bool? |
  /// | windspeed_10m_max          | bool? |
  /// | windgusts_10m_max          | bool? |
  /// | winddirection_10m_dominant | bool? |
  /// | shortwave_radiation_sum    | bool? |
  /// | et0_fao_evapotranspiration | bool? |
  /// | all                        | bool? |
  ///
  /// `all` attribute to get all ifnomations.
  ///
  /// Example:
  ///
  /// ```
  /// Daily sun_moon = Daily(sunrise: true, sunset: true);
  /// ```
  ///
  /// To learn more what are these attributes mean, go to [OpenMeteo's docs](https://open-meteo.com/en/docs).
  bool? weathercode,
      temperature_2m_max,
      temperature_2m_min,
      apparent_temperature_max,
      apparent_temperature_min,
      sunrise,
      sunset,
      precipitation_sum,
      rain_sum,
      showers_sum,
      snowfall_sum,
      precipitation_hours,
      windspeed_10m_max,
      windgusts_10m_max,
      winddirection_10m_dominant,
      shortwave_radiation_sum,
      et0_fao_evapotranspiration,
      all;
  Daily(
      {this.weathercode,
      this.temperature_2m_max,
      this.temperature_2m_min,
      this.apparent_temperature_max,
      this.apparent_temperature_min,
      this.sunrise,
      this.sunset,
      this.precipitation_sum,
      this.rain_sum,
      this.showers_sum,
      this.snowfall_sum,
      this.precipitation_hours,
      this.windspeed_10m_max,
      this.windgusts_10m_max,
      this.winddirection_10m_dominant,
      this.shortwave_radiation_sum,
      this.et0_fao_evapotranspiration}) {
    weathercode = weathercode ?? false;
    temperature_2m_max = temperature_2m_max ?? false;
    temperature_2m_min = temperature_2m_min ?? false;
    apparent_temperature_max = apparent_temperature_max ?? false;
    apparent_temperature_min = apparent_temperature_min ?? false;
    sunrise = sunrise ?? false;
    sunset = sunset ?? false;
    precipitation_sum = precipitation_sum ?? false;
    rain_sum = rain_sum ?? false;
    showers_sum = showers_sum ?? false;
    snowfall_sum = snowfall_sum ?? false;
    precipitation_hours = precipitation_hours ?? false;
    windspeed_10m_max = windspeed_10m_max ?? false;
    windgusts_10m_max = windgusts_10m_max ?? false;
    winddirection_10m_dominant = winddirection_10m_dominant ?? false;
    shortwave_radiation_sum = shortwave_radiation_sum ?? false;
    et0_fao_evapotranspiration = et0_fao_evapotranspiration ?? false;
    all = all ?? false;
  }
}

class Hourly {
  /// A class to specify what you want out of the API for hourly infomations.
  ///
  /// | attributes                 | type  |
  /// |----------------------------|-------|
  /// | temperature_2m             | bool? |
  /// | temperature_80m            | bool? |
  /// | temperature_120m           | bool? |
  /// | temperature_180m           | bool? |
  /// | relativehumidity_2m        | bool? |
  /// | dewpoint_2m                | bool? |
  /// | apparent_temperature       | bool? |
  /// | pressure_msl               | bool? |
  /// | surface_pressure           | bool? |
  /// | cloudcover                 | bool? |
  /// | cloudcover_low             | bool? |
  /// | cloudcover_mid             | bool? |
  /// | cloudcover_high            | bool? |
  /// | windspeed_10m              | bool? |
  /// | windspeed_80m              | bool? |
  /// | windspeed_120m             | bool? |
  /// | windspeed_180m             | bool? |
  /// | winddirection_10m          | bool? |
  /// | winddirection_80m          | bool? |
  /// | winddirection_120m         | bool? |
  /// | winddirection_180m         | bool? |
  /// | windgusts_10m              | bool? |
  /// | shortwave_radiation        | bool? |
  /// | direct_radiation           | bool? |
  /// | direct_normal_irradiance   | bool? |
  /// | diffuse_radiation          | bool? |
  /// | vapor_pressure_deficit     | bool? |
  /// | cape                       | bool? |
  /// | evapotranspiration         | bool? |
  /// | et0_fao_evapotranspiration | bool? |
  /// | precipitation              | bool? |
  /// | snowfall                   | bool? |
  /// | rain                       | bool? |
  /// | showers                    | bool? |
  /// | weathercode                | bool? |
  /// | snow_depth                 | bool? |
  /// | freezinglevel_height       | bool? |
  /// | visibility                 | bool? |
  /// | soil_temperature_0cm       | bool? |
  /// | soil_temperature_6cm       | bool? |
  /// | soil_temperature_18cm      | bool? |
  /// | soil_temperature_54cm      | bool? |
  /// | soil_moisture_0_1cm        | bool? |
  /// | soil_moisture_1_3cm        | bool? |
  /// | soil_moisture_3_9cm        | bool? |
  /// | soil_moisture_9_27cm       | bool? |
  /// | soil_moisture_27_81cm      | bool? |
  /// | all                        | bool? |
  ///
  /// `all` attribute to get all ifnomations.
  ///
  /// Example:
  ///
  /// ```
  /// Hourly temp_cloud = Hourly(temperature_2m: true, cloudcover: true);
  /// ```
  ///
  /// To learn more about what are these attributes mean, go to [OpenMeteo's docs](https://open-meteo.com/en/docs).
  bool? temperature_2m,
      temperature_80m,
      temperature_120m,
      temperature_180m,
      relativehumidity_2m,
      dewpoint_2m,
      apparent_temperature,
      pressure_msl,
      surface_pressure,
      cloudcover,
      cloudcover_low,
      cloudcover_mid,
      cloudcover_high,
      windspeed_10m,
      windspeed_80m,
      windspeed_120m,
      windspeed_180m,
      winddirection_10m,
      winddirection_80m,
      winddirection_120m,
      winddirection_180m,
      windgusts_10m,
      shortwave_radiation,
      direct_radiation,
      direct_normal_irradiance,
      diffuse_radiation,
      vapor_pressure_deficit,
      cape,
      evapotranspiration,
      et0_fao_evapotranspiration,
      precipitation,
      snowfall,
      rain,
      showers,
      weathercode,
      snow_depth,
      freezinglevel_height,
      visibility,
      soil_temperature_0cm,
      soil_temperature_6cm,
      soil_temperature_18cm,
      soil_temperature_54cm,
      soil_moisture_0_1cm,
      soil_moisture_1_3cm,
      soil_moisture_3_9cm,
      soil_moisture_9_27cm,
      soil_moisture_27_81cm,
      all;
  Hourly(
      {this.temperature_2m,
      this.temperature_80m,
      this.temperature_120m,
      this.temperature_180m,
      this.relativehumidity_2m,
      this.dewpoint_2m,
      this.apparent_temperature,
      this.pressure_msl,
      this.surface_pressure,
      this.cloudcover,
      this.cloudcover_low,
      this.cloudcover_mid,
      this.cloudcover_high,
      this.windspeed_10m,
      this.windspeed_80m,
      this.windspeed_120m,
      this.windspeed_180m,
      this.winddirection_10m,
      this.winddirection_80m,
      this.winddirection_120m,
      this.winddirection_180m,
      this.windgusts_10m,
      this.shortwave_radiation,
      this.direct_radiation,
      this.direct_normal_irradiance,
      this.diffuse_radiation,
      this.vapor_pressure_deficit,
      this.cape,
      this.evapotranspiration,
      this.et0_fao_evapotranspiration,
      this.precipitation,
      this.snowfall,
      this.rain,
      this.showers,
      this.weathercode,
      this.snow_depth,
      this.freezinglevel_height,
      this.visibility,
      this.soil_temperature_0cm,
      this.soil_temperature_6cm,
      this.soil_temperature_18cm,
      this.soil_temperature_54cm,
      this.soil_moisture_0_1cm,
      this.soil_moisture_1_3cm,
      this.soil_moisture_3_9cm,
      this.soil_moisture_9_27cm,
      this.soil_moisture_27_81cm,
      this.all}) {
    temperature_2m = temperature_2m ?? false;
    temperature_80m = temperature_80m ?? false;
    temperature_120m = temperature_120m ?? false;
    temperature_180m = temperature_180m ?? false;
    relativehumidity_2m = relativehumidity_2m ?? false;
    dewpoint_2m = dewpoint_2m ?? false;
    apparent_temperature = apparent_temperature ?? false;
    precipitation = precipitation ?? false;
    rain = rain ?? false;
    showers = showers ?? false;
    snowfall = snowfall ?? false;
    snow_depth = snow_depth ?? false;
    freezinglevel_height = freezinglevel_height ?? false;
    weathercode = weathercode ?? false;
    pressure_msl = pressure_msl ?? false;
    surface_pressure = surface_pressure ?? false;
    cloudcover = cloudcover ?? false;
    cloudcover_low = cloudcover_low ?? false;
    cloudcover_mid = cloudcover_mid ?? false;
    cloudcover_high = cloudcover_high ?? false;
    visibility = visibility ?? false;
    evapotranspiration = evapotranspiration ?? false;
    et0_fao_evapotranspiration = et0_fao_evapotranspiration ?? false;
    vapor_pressure_deficit = vapor_pressure_deficit ?? false;
    cape = cape ?? false;
    windspeed_10m = windspeed_10m ?? false;
    windspeed_80m = windspeed_80m ?? false;
    windspeed_120m = windspeed_120m ?? false;
    windspeed_180m = windspeed_180m ?? false;
    winddirection_10m = winddirection_10m ?? false;
    winddirection_80m = winddirection_80m ?? false;
    winddirection_120m = winddirection_120m ?? false;
    winddirection_180m = winddirection_180m ?? false;
    windgusts_10m = windgusts_10m ?? false;
    soil_temperature_0cm = soil_temperature_0cm ?? false;
    soil_temperature_6cm = soil_temperature_6cm ?? false;
    soil_temperature_18cm = soil_temperature_18cm ?? false;
    soil_temperature_54cm = soil_temperature_54cm ?? false;
    soil_moisture_0_1cm = soil_moisture_0_1cm ?? false;
    soil_moisture_1_3cm = soil_moisture_1_3cm ?? false;
    soil_moisture_3_9cm = soil_moisture_3_9cm ?? false;
    soil_moisture_9_27cm = soil_moisture_9_27cm ?? false;
    soil_moisture_27_81cm = soil_moisture_27_81cm ?? false;
    all = all ?? false;
  }
}

class TemperatureUnit {
  /// Set response's temperature unit.
  ///
  /// Example (set response's temperature unit to fahrenheit):
  ///
  /// ```
  /// OpenMeteo(
  /// ...
  ///   temperature_unit: TemperatureUnit.fahrenheit
  /// )
  /// ```
  static TemperatureUnit celsius = TemperatureUnit(type: "celsius"),
      fahrenheit = TemperatureUnit(type: "fahrenheit");

  String type;
  TemperatureUnit({required this.type});
}

class WindspeedUnit {
  /// Set response's windspeed unit.
  ///
  /// Example (set response's windspeed unit to m/s):
  ///
  /// ```
  /// OpenMeteo(
  /// ...
  ///   windspeed_unit: WindspeedUnit.ms
  /// )
  /// ```
  static WindspeedUnit kmh = WindspeedUnit(type: "kmh"),
      ms = WindspeedUnit(type: "ms"),
      mph = WindspeedUnit(type: "mph"),
      kn = WindspeedUnit(type: "kn");

  String type;
  WindspeedUnit({required this.type});
}

class PrecipitationUnit {
  /// Set response's precipitation unit.
  ///
  /// Example (set response's precipitation unit to inch):
  ///
  /// ```
  /// OpenMeteo(
  /// ...
  ///   precipitation_unit: PrecipitationUnit.inch
  /// )
  /// ```
  static PrecipitationUnit mm = PrecipitationUnit(type: "mm"),
      inch = PrecipitationUnit(type: "inch");

  String type;
  PrecipitationUnit({required this.type});
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

class Geocoding {
  /// Search locations in any language globally.
  ///
  /// | attributes | type    |
  /// |------------|---------|
  /// | name       | String  |
  /// | count      | int?    |
  /// | language   | String? |
  ///
  /// If `name` attributes is empty, this function will return `{}`
  ///
  /// [Return object format](https://open-meteo.com/en/docs/geocoding-api#api-documentation)
  Future<dynamic> search(
      {required String name, int? count, String? language}) async {
    if (name.isEmpty) {
      return {};
    }
    return jsonDecode((await http.get(Uri.parse(
            "https://geocoding-api.open-meteo.com/v1/search?name=$name${count != null ? "&count=$count" : ""}${language != null ? "&language=$language" : ""}")))
        .body);
  }
}
