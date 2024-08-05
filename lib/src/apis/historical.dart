import '../api.dart';
import '../options.dart';
import '../response.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Discover how weather has shaped our world from 1940 until now.
///
/// https://open-meteo.com/en/docs/historical-weather-api/
class HistoricalApi extends BaseApi {
  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;

  HistoricalApi({
    super.apiUrl = 'https://archive-api.open-meteo.com/v1/archive',
    super.apiKey,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.elevation,
  });

  HistoricalApi copyWith(
    String? apiUrl,
    String? apiKey,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    double? elevation,
  ) =>
      HistoricalApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
        elevation: elevation ?? this.elevation,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    required DateTime startDate,
    required DateTime endDate,
    List<HistoricalHourly>? hourly,
    List<HistoricalDaily>? daily,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          startDate: startDate,
          endDate: endDate,
          hourly: hourly,
          daily: daily,
        ),
      );

  Future<ApiResponse<HistoricalApi>> request({
    required double latitude,
    required double longitude,
    required DateTime startDate,
    required DateTime endDate,
    List<HistoricalHourly>? hourly,
    List<HistoricalDaily>? daily,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          startDate: startDate,
          endDate: endDate,
          hourly: hourly,
          daily: daily,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data,
          hourlyHashes: HistoricalHourly.hashes,
          dailyHashes: HistoricalDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required DateTime startDate,
    required DateTime endDate,
    required List<HistoricalHourly>? hourly,
    required List<HistoricalDaily>? daily,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'hourly': hourly,
        'daily': daily,
        'temperature_unit': temperatureUnit,
        'windspeed_unit': windspeedUnit,
        'precipitaion_unit': precipitationUnit,
        'cell_selection': cellSelection,
        'elevation': elevation,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

enum HistoricalHourly with WeatherParameter<HistoricalApi, Hourly> {
  temperature_2m(Variable.temperature, altitude: 2),
  relative_humidity_2m(Variable.relative_humidity, altitude: 2),
  dew_point_2m(Variable.dew_point, altitude: 2),
  apparent_temperature(Variable.apparent_temperature, altitude: 2),
  precipitation(Variable.precipitation),
  rain(Variable.rain),
  snowfall(Variable.snowfall),
  snow_depth(Variable.snow_depth),
  weather_code(Variable.weather_code),
  pressure_msl(Variable.pressure_msl),
  surface_pressure(Variable.surface_pressure),
  cloud_cover(Variable.cloud_cover),
  cloud_cover_low(Variable.cloud_cover_low),
  cloud_cover_mid(Variable.cloud_cover_mid),
  cloud_cover_high(Variable.cloud_cover_high),
  et0_fao_evapotranspiration(Variable.et0_fao_evapotranspiration),
  vapour_pressure_deficit(Variable.vapour_pressure_deficit),
  wind_speed_10m(Variable.wind_speed, altitude: 10),
  wind_speed_100m(Variable.wind_speed, altitude: 100),
  wind_direction_10m(Variable.wind_direction, altitude: 10),
  wind_direction_100m(Variable.wind_direction, altitude: 100),
  wind_gusts_10m(Variable.wind_gusts, altitude: 10),
  soil_temperature_0_to_7cm(Variable.soil_temperature, depth: 0, depthTo: 7),
  soil_temperature_7_to_28cm(Variable.soil_temperature, depth: 7, depthTo: 28),
  soil_temperature_28_to_100cm(Variable.soil_temperature,
      depth: 28, depthTo: 100),
  soil_temperature_100_to_255cm(Variable.soil_temperature,
      depth: 100, depthTo: 255),
  soil_moisture_0_to_7cm(Variable.soil_moisture, depth: 0, depthTo: 7),
  soil_moisture_7_to_28cm(Variable.soil_moisture, depth: 7, depthTo: 28),
  soil_moisture_28_to_100cm(Variable.soil_moisture, depth: 28, depthTo: 100),
  soil_moisture_100_to_255cm(Variable.soil_moisture, depth: 100, depthTo: 255),
  is_day(Variable.is_day),
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
  terrestrial_radiation_instant(Variable.terrestrial_radiation_instant);

  @override
  final Variable variable;

  @override
  final int altitude;
  @override
  final int depth;
  @override
  final int depthTo;

  const HistoricalHourly(
    this.variable, {
    this.altitude = 0,
    this.depth = 0,
    this.depthTo = 0,
  });

  static final Map<int, HistoricalHourly> hashes =
      makeHashes(HistoricalHourly.values);
}

enum HistoricalDaily with WeatherParameter<HistoricalApi, Daily> {
  weather_code(Variable.weather_code),
  temperature_2m_max(Variable.temperature,
      altitude: 2, aggregation: Aggregation.maximum),
  temperature_2m_min(Variable.temperature,
      altitude: 2, aggregation: Aggregation.minimum),
  temperature_2m_mean(Variable.temperature,
      altitude: 2, aggregation: Aggregation.mean),
  apparent_temperature_max(Variable.apparent_temperature,
      altitude: 2, aggregation: Aggregation.maximum),
  apparent_temperature_min(Variable.apparent_temperature,
      altitude: 2, aggregation: Aggregation.minimum),
  apparent_temperature_mean(Variable.apparent_temperature,
      altitude: 2, aggregation: Aggregation.mean),
  sunrise(Variable.sunrise),
  sunset(Variable.sunset),
  daylight_duration(Variable.daylight_duration),
  sunshine_duration(Variable.sunshine_duration),
  precipitation_sum(Variable.precipitation, aggregation: Aggregation.sum),
  rain_sum(Variable.rain, aggregation: Aggregation.sum),
  snowfall_sum(Variable.snowfall, aggregation: Aggregation.sum),
  precipitation_hours(Variable.precipitation_hours),
  wind_speed_10m_max(Variable.wind_speed,
      altitude: 10, aggregation: Aggregation.maximum),
  wind_gusts_10m_max(Variable.wind_gusts,
      altitude: 10, aggregation: Aggregation.maximum),
  wind_direction_10m_dominant(Variable.wind_direction,
      altitude: 10, aggregation: Aggregation.dominant),
  shortwave_radiation_sum(Variable.shortwave_radiation,
      aggregation: Aggregation.sum),
  et0_fao_evapotranspiration(Variable.et0_fao_evapotranspiration);

  @override
  final Variable variable;

  @override
  final int altitude;
  @override
  final Aggregation aggregation;

  const HistoricalDaily(
    this.variable, {
    this.altitude = 0,
    this.aggregation = Aggregation.none,
  });

  static final Map<int, HistoricalDaily> hashes =
      makeHashes(HistoricalDaily.values);
}
