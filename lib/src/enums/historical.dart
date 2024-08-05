import '../api.dart';
import '../apis/historical.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

enum HistoricalHourly with Parameter<HistoricalApi, Hourly> {
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
  wind_speed_10m(
    Variable.wind_speed,
    altitude: 10,
  ),
  wind_speed_100m(
    Variable.wind_speed,
    altitude: 100,
  ),
  wind_direction_10m(
    Variable.wind_direction,
    altitude: 10,
  ),
  wind_direction_100m(
    Variable.wind_direction,
    altitude: 100,
  ),
  wind_gusts_10m(
    Variable.wind_gusts,
    altitude: 10,
  ),
  soil_temperature_0_to_7cm(
    Variable.soil_temperature,
    depth: 0,
    depthTo: 7,
  ),
  soil_temperature_7_to_28cm(
    Variable.soil_temperature,
    depth: 7,
    depthTo: 28,
  ),
  soil_temperature_28_to_100cm(
    Variable.soil_temperature,
    depth: 28,
    depthTo: 100,
  ),
  soil_temperature_100_to_255cm(
    Variable.soil_temperature,
    depth: 100,
    depthTo: 255,
  ),
  soil_moisture_0_to_7cm(
    Variable.soil_moisture,
    depth: 0,
    depthTo: 7,
  ),
  soil_moisture_7_to_28cm(
    Variable.soil_moisture,
    depth: 7,
    depthTo: 28,
  ),
  soil_moisture_28_to_100cm(
    Variable.soil_moisture,
    depth: 28,
    depthTo: 100,
  ),
  soil_moisture_100_to_255cm(
    Variable.soil_moisture,
    depth: 100,
    depthTo: 255,
  ),
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

enum HistoricalDaily with Parameter<HistoricalApi, Daily> {
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
  temperature_2m_mean(
    Variable.temperature,
    altitude: 2,
    aggregation: Aggregation.mean,
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
  apparent_temperature_mean(
    Variable.apparent_temperature,
    altitude: 2,
    aggregation: Aggregation.mean,
  ),
  sunrise(Variable.sunrise),
  sunset(Variable.sunset),
  daylight_duration(Variable.daylight_duration),
  sunshine_duration(Variable.sunshine_duration),
  precipitation_sum(
    Variable.precipitation,
    aggregation: Aggregation.sum,
  ),
  rain_sum(
    Variable.rain,
    aggregation: Aggregation.sum,
  ),
  snowfall_sum(
    Variable.snowfall,
    aggregation: Aggregation.sum,
  ),
  precipitation_hours(Variable.precipitation_hours),
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
