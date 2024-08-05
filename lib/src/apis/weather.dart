import '../api.dart';
import '../options.dart';
import '../response.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Seamless integration of high-resolution weather models with up 16 days forecast.
///
/// https://open-meteo.com/en/docs/
class WeatherApi extends BaseApi {
  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;
  final int? pastDays, pastHours, pastMinutely15;
  final int? forecastDays, forecastHours, forecastMinutely15;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;

  WeatherApi({
    super.apiUrl = 'https://api.open-meteo.com/v1/forecast',
    super.apiKey,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.elevation,
    this.pastDays,
    this.pastHours,
    this.pastMinutely15,
    this.forecastDays,
    this.forecastHours,
    this.forecastMinutely15,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
  });

  WeatherApi copyWith({
    String? apiUrl,
    String? apiKey,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    double? elevation,
    int? pastDays,
    int? pastHours,
    int? pastMinutely15,
    int? forecastDays,
    int? forecastHours,
    int? forecastMinutely15,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startHour,
    DateTime? endHour,
  }) =>
      WeatherApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
        elevation: elevation ?? this.elevation,
        pastDays: pastDays ?? this.pastDays,
        pastHours: pastHours ?? this.pastHours,
        pastMinutely15: pastMinutely15 ?? this.pastMinutely15,
        forecastDays: forecastDays ?? this.forecastDays,
        forecastHours: forecastHours ?? this.forecastHours,
        forecastMinutely15: forecastMinutely15 ?? this.forecastMinutely15,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startHour: startHour ?? this.startHour,
        endHour: endHour ?? this.endHour,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<WeatherHourly>? hourly,
    List<WeatherDaily>? daily,
    List<WeatherCurrent>? current,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          current: current,
        ),
      );

  Future<ApiResponse<WeatherApi>> request({
    required double latitude,
    required double longitude,
    List<WeatherHourly>? hourly,
    List<WeatherDaily>? daily,
    List<WeatherCurrent>? current,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          current: current,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data,
          currentHashes: WeatherCurrent.hashes,
          hourlyHashes: WeatherHourly.hashes,
          dailyHashes: WeatherDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required List<WeatherHourly>? hourly,
    required List<WeatherDaily>? daily,
    required List<WeatherCurrent>? current,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'current': current,
        'hourly': hourly,
        'daily': daily,
        'temperature_unit': temperatureUnit,
        'windspeed_unit': windspeedUnit,
        'precipitation_unit': precipitationUnit,
        'cell_selection': cellSelection,
        'elevation': elevation,
        'past_days': pastDays,
        'past_hours': pastHours,
        'past_minutely_15': pastMinutely15,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'forecast_minutely_15': forecastMinutely15,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

// typedef WeatherResponse = Response<WeatherApi>;

enum WeatherCurrent with WeatherParameter<WeatherApi, Current> {
  temperature_2m(
    Variable.temperature,
    altitude: 2,
  ),
  relative_humidity_2m(
    Variable.relative_humidity,
    altitude: 2,
  ),
  apparent_temperature(
    Variable.apparent_temperature,
    altitude: 2,
  ),
  is_day(Variable.is_day),
  precipitation(Variable.precipitation),
  rain(Variable.rain),
  showers(Variable.showers),
  snowfall(Variable.snowfall),
  weather_code(Variable.weather_code),
  cloud_cover(Variable.cloud_cover),
  pressure_msl(Variable.pressure_msl),
  surface_pressure(Variable.surface_pressure),
  wind_speed_10m(
    Variable.wind_speed,
    altitude: 10,
  ),
  wind_direction_10m(
    Variable.wind_direction,
    altitude: 10,
  ),
  wind_gusts_10m(
    Variable.wind_gusts,
    altitude: 10,
  );

  @override
  final Variable variable;

  @override
  final int altitude;

  const WeatherCurrent(
    this.variable, {
    this.altitude = 0,
  });

  static final Map<int, WeatherCurrent> hashes =
      makeHashes(WeatherCurrent.values);
}

enum WeatherHourly with WeatherParameter<WeatherApi, Hourly> {
  temperature_2m(
    Variable.temperature,
    altitude: 2,
  ),
  relative_humidity_2m(
    Variable.relative_humidity,
    altitude: 2,
  ),
  dew_point_2m(
    Variable.dew_point,
    altitude: 2,
  ),
  apparent_temperature(
    Variable.apparent_temperature,
    altitude: 2,
  ),
  precipitation_probability(Variable.precipitation_probability),
  precipitation(Variable.precipitation),
  rain(Variable.rain),
  showers(Variable.showers),
  snowfall(Variable.snowfall),
  snow_depth(Variable.snow_depth),
  weather_code(Variable.weather_code),
  pressure_msl(Variable.pressure_msl),
  surface_pressure(Variable.surface_pressure),
  cloud_cover(Variable.cloud_cover),
  cloud_cover_low(Variable.cloud_cover_low),
  cloud_cover_mid(Variable.cloud_cover_mid),
  cloud_cover_high(Variable.cloud_cover_high),
  visibility(Variable.visibility),
  evapotranspiration(Variable.evapotranspiration),
  et0_fao_evapotranspiration(Variable.et0_fao_evapotranspiration),
  vapour_pressure_deficit(Variable.vapour_pressure_deficit),
  wind_speed_10m(
    Variable.wind_speed,
    altitude: 10,
  ),
  wind_speed_80m(
    Variable.wind_speed,
    altitude: 80,
  ),
  wind_speed_120m(
    Variable.wind_speed,
    altitude: 120,
  ),
  wind_speed_180m(
    Variable.wind_speed,
    altitude: 180,
  ),
  wind_direction_10m(
    Variable.wind_direction,
    altitude: 10,
  ),
  wind_direction_80m(
    Variable.wind_direction,
    altitude: 80,
  ),
  wind_direction_120m(
    Variable.wind_direction,
    altitude: 120,
  ),
  wind_direction_180m(
    Variable.wind_direction,
    altitude: 180,
  ),
  wind_gusts_10m(
    Variable.wind_gusts,
    altitude: 10,
  ),
  temperature_80m(
    Variable.temperature,
    altitude: 80,
  ),
  temperature_120m(
    Variable.temperature,
    altitude: 120,
  ),
  temperature_180m(
    Variable.temperature,
    altitude: 180,
  ),
  soil_temperature_0cm(
    Variable.soil_temperature,
    depth: 0,
  ),
  soil_temperature_6cm(
    Variable.soil_temperature,
    depth: 6,
  ),
  soil_temperature_18cm(
    Variable.soil_temperature,
    depth: 18,
  ),
  soil_temperature_54cm(
    Variable.soil_temperature,
    depth: 54,
  ),
  soil_moisture_0_to_1cm(
    Variable.soil_moisture,
    depth: 0,
    depthTo: 1,
  ),
  soil_moisture_1_to_3cm(
    Variable.soil_moisture,
    depth: 1,
    depthTo: 3,
  ),
  soil_moisture_3_to_9cm(
    Variable.soil_moisture,
    depth: 3,
    depthTo: 9,
  ),
  soil_moisture_9_to_27cm(
    Variable.soil_moisture,
    depth: 9,
    depthTo: 27,
  ),
  soil_moisture_27_to_81cm(
    Variable.soil_moisture,
    depth: 27,
    depthTo: 81,
  ),
  uv_index(Variable.uv_index),
  uv_index_clear_sky(Variable.uv_index_clear_sky),
  is_day(Variable.is_day),
  cape(Variable.cape),
  freezing_level_height(Variable.freezing_level_height),
  sunshine_duration(Variable.sunshine_duration),
  shortwave_radiation(Variable.shortwave_radiation),
  direct_radiation(Variable.direct_radiation),
  diffuse_radiation(Variable.diffuse_radiation),
  direct_normal_irradiance(Variable.direct_normal_irradiance),
  global_tilted_irradiance(Variable.global_tilted_irradiance),
  terrestrial_radiation(Variable.terrestrial_radiation),
  shortwave_radiation_instant(Variable.shortwave_radiation_instant),
  direct_radiation_instant(Variable.direct_radiation_instant),
  diffuse_radiation_instant(Variable.diffuse_radiation_instant),
  direct_normal_irradiance_instant(Variable.direct_normal_irradiance_instant),
  global_tilted_irradiance_instant(Variable.global_tilted_irradiance_instant),
  terrestrial_radiation_instant(Variable.terrestrial_radiation_instant),
  temperature_1000hPa(
    Variable.temperature,
    pressureLevel: 1000,
  ),
  temperature_975hPa(
    Variable.temperature,
    pressureLevel: 975,
  ),
  temperature_950hPa(
    Variable.temperature,
    pressureLevel: 950,
  ),
  temperature_925hPa(
    Variable.temperature,
    pressureLevel: 925,
  ),
  temperature_900hPa(
    Variable.temperature,
    pressureLevel: 900,
  ),
  temperature_850hPa(
    Variable.temperature,
    pressureLevel: 850,
  ),
  temperature_800hPa(
    Variable.temperature,
    pressureLevel: 800,
  ),
  temperature_700hPa(
    Variable.temperature,
    pressureLevel: 700,
  ),
  temperature_600hPa(
    Variable.temperature,
    pressureLevel: 600,
  ),
  temperature_500hPa(
    Variable.temperature,
    pressureLevel: 500,
  ),
  temperature_400hPa(
    Variable.temperature,
    pressureLevel: 400,
  ),
  temperature_300hPa(
    Variable.temperature,
    pressureLevel: 300,
  ),
  temperature_250hPa(
    Variable.temperature,
    pressureLevel: 250,
  ),
  temperature_200hPa(
    Variable.temperature,
    pressureLevel: 200,
  ),
  temperature_150hPa(
    Variable.temperature,
    pressureLevel: 150,
  ),
  temperature_100hPa(
    Variable.temperature,
    pressureLevel: 100,
  ),
  temperature_70hPa(
    Variable.temperature,
    pressureLevel: 70,
  ),
  temperature_50hPa(
    Variable.temperature,
    pressureLevel: 50,
  ),
  temperature_30hPa(
    Variable.temperature,
    pressureLevel: 30,
  ),
  relative_humidity_1000hPa(
    Variable.relative_humidity,
    pressureLevel: 1000,
  ),
  relative_humidity_975hPa(
    Variable.relative_humidity,
    pressureLevel: 975,
  ),
  relative_humidity_950hPa(
    Variable.relative_humidity,
    pressureLevel: 950,
  ),
  relative_humidity_925hPa(
    Variable.relative_humidity,
    pressureLevel: 925,
  ),
  relative_humidity_900hPa(
    Variable.relative_humidity,
    pressureLevel: 900,
  ),
  relative_humidity_850hPa(
    Variable.relative_humidity,
    pressureLevel: 850,
  ),
  relative_humidity_800hPa(
    Variable.relative_humidity,
    pressureLevel: 800,
  ),
  relative_humidity_700hPa(
    Variable.relative_humidity,
    pressureLevel: 700,
  ),
  relative_humidity_600hPa(
    Variable.relative_humidity,
    pressureLevel: 600,
  ),
  relative_humidity_500hPa(
    Variable.relative_humidity,
    pressureLevel: 500,
  ),
  relative_humidity_400hPa(
    Variable.relative_humidity,
    pressureLevel: 400,
  ),
  relative_humidity_300hPa(
    Variable.relative_humidity,
    pressureLevel: 300,
  ),
  relative_humidity_250hPa(
    Variable.relative_humidity,
    pressureLevel: 250,
  ),
  relative_humidity_200hPa(
    Variable.relative_humidity,
    pressureLevel: 200,
  ),
  relative_humidity_150hPa(
    Variable.relative_humidity,
    pressureLevel: 150,
  ),
  relative_humidity_100hPa(
    Variable.relative_humidity,
    pressureLevel: 100,
  ),
  relative_humidity_70hPa(
    Variable.relative_humidity,
    pressureLevel: 70,
  ),
  relative_humidity_50hPa(
    Variable.relative_humidity,
    pressureLevel: 50,
  ),
  relative_humidity_30hPa(
    Variable.relative_humidity,
    pressureLevel: 30,
  ),
  cloud_cover_1000hPa(
    Variable.cloud_cover,
    pressureLevel: 1000,
  ),
  cloud_cover_975hPa(
    Variable.cloud_cover,
    pressureLevel: 975,
  ),
  cloud_cover_950hPa(
    Variable.cloud_cover,
    pressureLevel: 950,
  ),
  cloud_cover_925hPa(
    Variable.cloud_cover,
    pressureLevel: 925,
  ),
  cloud_cover_900hPa(
    Variable.cloud_cover,
    pressureLevel: 900,
  ),
  cloud_cover_850hPa(
    Variable.cloud_cover,
    pressureLevel: 850,
  ),
  cloud_cover_800hPa(
    Variable.cloud_cover,
    pressureLevel: 800,
  ),
  cloud_cover_700hPa(
    Variable.cloud_cover,
    pressureLevel: 700,
  ),
  cloud_cover_600hPa(
    Variable.cloud_cover,
    pressureLevel: 600,
  ),
  cloud_cover_500hPa(
    Variable.cloud_cover,
    pressureLevel: 500,
  ),
  cloud_cover_400hPa(
    Variable.cloud_cover,
    pressureLevel: 400,
  ),
  cloud_cover_300hPa(
    Variable.cloud_cover,
    pressureLevel: 300,
  ),
  cloud_cover_250hPa(
    Variable.cloud_cover,
    pressureLevel: 250,
  ),
  cloud_cover_200hPa(
    Variable.cloud_cover,
    pressureLevel: 200,
  ),
  cloud_cover_150hPa(
    Variable.cloud_cover,
    pressureLevel: 150,
  ),
  cloud_cover_100hPa(
    Variable.cloud_cover,
    pressureLevel: 100,
  ),
  cloud_cover_70hPa(
    Variable.cloud_cover,
    pressureLevel: 70,
  ),
  cloud_cover_50hPa(
    Variable.cloud_cover,
    pressureLevel: 50,
  ),
  cloud_cover_30hPa(
    Variable.cloud_cover,
    pressureLevel: 30,
  ),
  windspeed_1000hPa(
    Variable.wind_speed,
    pressureLevel: 1000,
  ),
  windspeed_975hPa(
    Variable.wind_speed,
    pressureLevel: 975,
  ),
  windspeed_950hPa(
    Variable.wind_speed,
    pressureLevel: 950,
  ),
  windspeed_925hPa(
    Variable.wind_speed,
    pressureLevel: 925,
  ),
  windspeed_900hPa(
    Variable.wind_speed,
    pressureLevel: 900,
  ),
  windspeed_850hPa(
    Variable.wind_speed,
    pressureLevel: 850,
  ),
  windspeed_800hPa(
    Variable.wind_speed,
    pressureLevel: 800,
  ),
  windspeed_700hPa(
    Variable.wind_speed,
    pressureLevel: 700,
  ),
  windspeed_600hPa(
    Variable.wind_speed,
    pressureLevel: 600,
  ),
  windspeed_500hPa(
    Variable.wind_speed,
    pressureLevel: 500,
  ),
  windspeed_400hPa(
    Variable.wind_speed,
    pressureLevel: 400,
  ),
  windspeed_300hPa(
    Variable.wind_speed,
    pressureLevel: 300,
  ),
  windspeed_250hPa(
    Variable.wind_speed,
    pressureLevel: 250,
  ),
  windspeed_200hPa(
    Variable.wind_speed,
    pressureLevel: 200,
  ),
  windspeed_150hPa(
    Variable.wind_speed,
    pressureLevel: 150,
  ),
  windspeed_100hPa(
    Variable.wind_speed,
    pressureLevel: 100,
  ),
  windspeed_70hPa(
    Variable.wind_speed,
    pressureLevel: 70,
  ),
  windspeed_50hPa(
    Variable.wind_speed,
    pressureLevel: 50,
  ),
  windspeed_30hPa(
    Variable.wind_speed,
    pressureLevel: 30,
  ),
  winddirection_1000hPa(
    Variable.wind_direction,
    pressureLevel: 1000,
  ),
  winddirection_975hPa(
    Variable.wind_direction,
    pressureLevel: 975,
  ),
  winddirection_950hPa(
    Variable.wind_direction,
    pressureLevel: 950,
  ),
  winddirection_925hPa(
    Variable.wind_direction,
    pressureLevel: 925,
  ),
  winddirection_900hPa(
    Variable.wind_direction,
    pressureLevel: 900,
  ),
  winddirection_850hPa(
    Variable.wind_direction,
    pressureLevel: 850,
  ),
  winddirection_800hPa(
    Variable.wind_direction,
    pressureLevel: 800,
  ),
  winddirection_700hPa(
    Variable.wind_direction,
    pressureLevel: 700,
  ),
  winddirection_600hPa(
    Variable.wind_direction,
    pressureLevel: 600,
  ),
  winddirection_500hPa(
    Variable.wind_direction,
    pressureLevel: 500,
  ),
  winddirection_400hPa(
    Variable.wind_direction,
    pressureLevel: 400,
  ),
  winddirection_300hPa(
    Variable.wind_direction,
    pressureLevel: 300,
  ),
  winddirection_250hPa(
    Variable.wind_direction,
    pressureLevel: 250,
  ),
  winddirection_200hPa(
    Variable.wind_direction,
    pressureLevel: 200,
  ),
  winddirection_150hPa(
    Variable.wind_direction,
    pressureLevel: 150,
  ),
  winddirection_100hPa(
    Variable.wind_direction,
    pressureLevel: 100,
  ),
  winddirection_70hPa(
    Variable.wind_direction,
    pressureLevel: 70,
  ),
  winddirection_50hPa(
    Variable.wind_direction,
    pressureLevel: 50,
  ),
  winddirection_30hPa(
    Variable.wind_direction,
    pressureLevel: 30,
  ),
  geopotential_height_1000hPa(
    Variable.geopotential_height,
    pressureLevel: 1000,
  ),
  geopotential_height_975hPa(
    Variable.geopotential_height,
    pressureLevel: 975,
  ),
  geopotential_height_950hPa(
    Variable.geopotential_height,
    pressureLevel: 950,
  ),
  geopotential_height_925hPa(
    Variable.geopotential_height,
    pressureLevel: 925,
  ),
  geopotential_height_900hPa(
    Variable.geopotential_height,
    pressureLevel: 900,
  ),
  geopotential_height_850hPa(
    Variable.geopotential_height,
    pressureLevel: 850,
  ),
  geopotential_height_800hPa(
    Variable.geopotential_height,
    pressureLevel: 800,
  ),
  geopotential_height_700hPa(
    Variable.geopotential_height,
    pressureLevel: 700,
  ),
  geopotential_height_600hPa(
    Variable.geopotential_height,
    pressureLevel: 600,
  ),
  geopotential_height_500hPa(
    Variable.geopotential_height,
    pressureLevel: 500,
  ),
  geopotential_height_400hPa(
    Variable.geopotential_height,
    pressureLevel: 400,
  ),
  geopotential_height_300hPa(
    Variable.geopotential_height,
    pressureLevel: 300,
  ),
  geopotential_height_250hPa(
    Variable.geopotential_height,
    pressureLevel: 250,
  ),
  geopotential_height_200hPa(
    Variable.geopotential_height,
    pressureLevel: 200,
  ),
  geopotential_height_150hPa(
    Variable.geopotential_height,
    pressureLevel: 150,
  ),
  geopotential_height_100hPa(
    Variable.geopotential_height,
    pressureLevel: 100,
  ),
  geopotential_height_70hPa(
    Variable.geopotential_height,
    pressureLevel: 70,
  ),
  geopotential_height_50hPa(
    Variable.geopotential_height,
    pressureLevel: 50,
  ),
  geopotential_height_30hPa(
    Variable.geopotential_height,
    pressureLevel: 30,
  );

  @override
  final Variable variable;

  @override
  final int altitude;
  @override
  final int depth;
  @override
  final int depthTo;
  @override
  final int pressureLevel;

  const WeatherHourly(
    this.variable, {
    this.altitude = 0,
    this.depth = 0,
    this.depthTo = 0,
    this.pressureLevel = 0,
  });

  static final Map<int, WeatherHourly> hashes =
      makeHashes(WeatherHourly.values);
}

enum WeatherDaily with WeatherParameter<WeatherApi, Daily> {
  weather_code(Variable.weather_code),
  temperature_2m_max(
    Variable.temperature,
    altitude: 2,
    aggregation: Aggregation.maximum,
  ),
  temperature_2m_min(
    Variable.temperature,
    altitude: 2,
    aggregation: Aggregation.minimum,
  ),
  apparent_temperature_max(
    Variable.apparent_temperature,
    altitude: 2,
    aggregation: Aggregation.maximum,
  ),
  apparent_temperature_min(
    Variable.apparent_temperature,
    altitude: 2,
    aggregation: Aggregation.minimum,
  ),
  sunrise(Variable.sunrise),
  sunset(Variable.sunset),
  daylight_duration(Variable.daylight_duration),
  sunshine_duration(Variable.sunshine_duration),
  uv_index_max(
    Variable.uv_index,
    aggregation: Aggregation.maximum,
  ),
  uv_index_clear_sky_max(
    Variable.uv_index_clear_sky,
    aggregation: Aggregation.maximum,
  ),
  precipitation_sum(
    Variable.precipitation,
    aggregation: Aggregation.sum,
  ),
  rain_sum(
    Variable.rain,
    aggregation: Aggregation.sum,
  ),
  showers_sum(
    Variable.showers,
    aggregation: Aggregation.sum,
  ),
  snowfall_sum(
    Variable.snowfall,
    aggregation: Aggregation.sum,
  ),
  precipitation_hours(Variable.precipitation_hours),
  precipitation_probability_max(
    Variable.precipitation_probability,
    aggregation: Aggregation.maximum,
  ),
  wind_speed_10m_max(
    Variable.wind_speed,
    altitude: 10,
    aggregation: Aggregation.maximum,
  ),
  wind_gusts_10m_max(
    Variable.wind_gusts,
    altitude: 10,
    aggregation: Aggregation.maximum,
  ),
  wind_direction_10m_dominant(
    Variable.wind_direction,
    altitude: 10,
    aggregation: Aggregation.dominant,
  ),
  shortwave_radiation_sum(
    Variable.shortwave_radiation,
    aggregation: Aggregation.sum,
  ),
  et0_fao_evapotranspiration(
    Variable.et0_fao_evapotranspiration,
  );

  @override
  final Variable variable;

  @override
  final int altitude;
  @override
  final Aggregation aggregation;

  const WeatherDaily(
    this.variable, {
    this.altitude = 0,
    this.aggregation = Aggregation.none,
  });

  static final Map<int, WeatherDaily> hashes = makeHashes(WeatherDaily.values);
}
