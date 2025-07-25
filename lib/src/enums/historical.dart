import '../api.dart';
import '../apis/historical.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

// Generated Variable Enums for Historical

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
  precipitation(
    Variable.precipitation,
  ),
  rain(
    Variable.rain,
  ),
  snowfall(
    Variable.snowfall,
  ),
  snow_depth(
    Variable.snow_depth,
  ),
  weather_code(
    Variable.weather_code,
  ),
  pressure_msl(
    Variable.pressure_msl,
  ),
  surface_pressure(
    Variable.surface_pressure,
  ),
  cloud_cover(
    Variable.cloud_cover,
  ),
  cloud_cover_low(
    Variable.cloud_cover_low,
  ),
  cloud_cover_mid(
    Variable.cloud_cover_mid,
  ),
  cloud_cover_high(
    Variable.cloud_cover_high,
  ),
  et0_fao_evapotranspiration(
    Variable.et0_fao_evapotranspiration,
  ),
  vapour_pressure_deficit(
    Variable.vapour_pressure_deficit,
  ),
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
  boundary_layer_height(
    Variable.boundary_layer_height,
  ),
  wet_bulb_temperature_2m(
    Variable.wet_bulb_temperature,
    altitude: 2,
  ),
  total_column_integrated_water_vapour(
    Variable.total_column_integrated_water_vapour,
  ),
  is_day(
    Variable.is_day,
  ),
  sunshine_duration(
    Variable.sunshine_duration,
  ),
  albedo(
    Variable.albedo,
  ),
  snow_depth_water_equivalent(
    Variable.snow_depth_water_equivalent,
  ),
  shortwave_radiation(
    Variable.shortwave_radiation,
  ),
  direct_radiation(
    Variable.direct_radiation,
  ),
  diffuse_radiation(
    Variable.diffuse_radiation,
  ),
  direct_normal_irradiance(
    Variable.direct_normal_irradiance,
  ),
  global_tilted_irradiance(
    Variable.global_tilted_irradiance,
  ),
  terrestrial_radiation(
    Variable.terrestrial_radiation,
  ),
  shortwave_radiation_instant(
    Variable.shortwave_radiation_instant,
  ),
  direct_radiation_instant(
    Variable.direct_radiation_instant,
  ),
  diffuse_radiation_instant(
    Variable.diffuse_radiation_instant,
  ),
  direct_normal_irradiance_instant(
    Variable.direct_normal_irradiance_instant,
  ),
  global_tilted_irradiance_instant(
    Variable.global_tilted_irradiance_instant,
  ),
  terrestrial_radiation_instant(
    Variable.terrestrial_radiation_instant,
  ),
  temperature_2m_spread(
    Variable.temperature,
    aggregation: Aggregation.spread,
    altitude: 2,
  ),
  dew_point_2m_spread(
    Variable.dew_point,
    aggregation: Aggregation.spread,
    altitude: 2,
  ),
  precipitation_spread(
    Variable.precipitation,
    aggregation: Aggregation.spread,
  ),
  snowfall_spread(
    Variable.snowfall,
    aggregation: Aggregation.spread,
  ),
  shortwave_radiation_spread(
    Variable.shortwave_radiation,
    aggregation: Aggregation.spread,
  ),
  direct_radiation_spread(
    Variable.direct_radiation,
    aggregation: Aggregation.spread,
  ),
  pressure_msl_spread(
    Variable.pressure_msl,
    aggregation: Aggregation.spread,
  ),
  cloud_cover_low_spread(
    Variable.cloud_cover_low,
    aggregation: Aggregation.spread,
  ),
  cloud_cover_mid_spread(
    Variable.cloud_cover_mid,
    aggregation: Aggregation.spread,
  ),
  cloud_cover_high_spread(
    Variable.cloud_cover_high,
    aggregation: Aggregation.spread,
  ),
  wind_speed_10m_spread(
    Variable.wind_speed,
    aggregation: Aggregation.spread,
    altitude: 10,
  ),
  wind_speed_100m_spread(
    Variable.wind_speed,
    aggregation: Aggregation.spread,
    altitude: 100,
  ),
  wind_direction_10m_spread(
    Variable.wind_direction,
    aggregation: Aggregation.spread,
    altitude: 10,
  ),
  wind_direction_100m_spread(
    Variable.wind_direction,
    aggregation: Aggregation.spread,
    altitude: 100,
  ),
  wind_gusts_10m_spread(
    Variable.wind_gusts,
    aggregation: Aggregation.spread,
    altitude: 10,
  ),
  soil_temperature_0_to_7cm_spread(
    Variable.soil_temperature,
    aggregation: Aggregation.spread,
    depth: 0,
    depthTo: 7,
  ),
  soil_temperature_7_to_28cm_spread(
    Variable.soil_temperature,
    aggregation: Aggregation.spread,
    depth: 7,
    depthTo: 28,
  ),
  soil_temperature_28_to_100cm_spread(
    Variable.soil_temperature,
    aggregation: Aggregation.spread,
    depth: 28,
    depthTo: 100,
  ),
  soil_temperature_100_to_255cm_spread(
    Variable.soil_temperature,
    aggregation: Aggregation.spread,
    depth: 100,
    depthTo: 255,
  ),
  soil_moisture_0_to_7cm_spread(
    Variable.soil_moisture,
    aggregation: Aggregation.spread,
    depth: 0,
    depthTo: 7,
  ),
  soil_moisture_7_to_28cm_spread(
    Variable.soil_moisture,
    aggregation: Aggregation.spread,
    depth: 7,
    depthTo: 28,
  ),
  soil_moisture_28_to_100cm_spread(
    Variable.soil_moisture,
    aggregation: Aggregation.spread,
    depth: 28,
    depthTo: 100,
  ),
  soil_moisture_100_to_255cm_spread(
    Variable.soil_moisture,
    aggregation: Aggregation.spread,
    depth: 100,
    depthTo: 255,
  ),
  ;

  @override
  final Variable variable;
  @override
  final int altitude;
  @override
  final int depth;
  @override
  final int depthTo;
  @override
  final Aggregation aggregation;
  const HistoricalHourly(
    this.variable, {
    this.altitude = 0,
    this.depth = 0,
    this.depthTo = 0,
    this.aggregation = Aggregation.none,
  });

  static final Map<int, HistoricalHourly> hashes =
      makeHashes(HistoricalHourly.values);
}

enum HistoricalDaily with Parameter<HistoricalApi, Daily> {
  weather_code(
    Variable.weather_code,
  ),
  temperature_2m_mean(
    Variable.temperature,
    aggregation: Aggregation.mean,
    altitude: 2,
  ),
  temperature_2m_max(
    Variable.temperature,
    aggregation: Aggregation.maximum,
    altitude: 2,
  ),
  temperature_2m_min(
    Variable.temperature,
    aggregation: Aggregation.minimum,
    altitude: 2,
  ),
  apparent_temperature_mean(
    Variable.apparent_temperature,
    aggregation: Aggregation.mean,
    altitude: 2,
  ),
  apparent_temperature_max(
    Variable.apparent_temperature,
    aggregation: Aggregation.maximum,
    altitude: 2,
  ),
  apparent_temperature_min(
    Variable.apparent_temperature,
    aggregation: Aggregation.minimum,
    altitude: 2,
  ),
  sunrise(
    Variable.sunrise,
  ),
  sunset(
    Variable.sunset,
  ),
  daylight_duration(
    Variable.daylight_duration,
  ),
  sunshine_duration(
    Variable.sunshine_duration,
  ),
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
  precipitation_hours(
    Variable.precipitation_hours,
  ),
  wind_speed_10m_max(
    Variable.wind_speed,
    aggregation: Aggregation.maximum,
    altitude: 10,
  ),
  wind_gusts_10m_max(
    Variable.wind_gusts,
    aggregation: Aggregation.maximum,
    altitude: 10,
  ),
  wind_direction_10m_dominant(
    Variable.wind_direction,
    aggregation: Aggregation.dominant,
    altitude: 10,
  ),
  shortwave_radiation_sum(
    Variable.shortwave_radiation,
    aggregation: Aggregation.sum,
  ),
  et0_fao_evapotranspiration(
    Variable.et0_fao_evapotranspiration,
  ),
  cape_mean(
    Variable.cape,
    aggregation: Aggregation.mean,
  ),
  cape_max(
    Variable.cape,
    aggregation: Aggregation.maximum,
  ),
  cape_min(
    Variable.cape,
    aggregation: Aggregation.minimum,
  ),
  cloud_cover_mean(
    Variable.cloud_cover,
    aggregation: Aggregation.mean,
  ),
  cloud_cover_max(
    Variable.cloud_cover,
    aggregation: Aggregation.maximum,
  ),
  cloud_cover_min(
    Variable.cloud_cover,
    aggregation: Aggregation.minimum,
  ),
  dew_point_2m_mean(
    Variable.dew_point,
    aggregation: Aggregation.mean,
    altitude: 2,
  ),
  dew_point_2m_max(
    Variable.dew_point,
    aggregation: Aggregation.maximum,
    altitude: 2,
  ),
  dew_point_2m_min(
    Variable.dew_point,
    aggregation: Aggregation.minimum,
    altitude: 2,
  ),
  et0_fao_evapotranspiration_sum(
    Variable.et0_fao_evapotranspiration,
    aggregation: Aggregation.sum,
  ),
  leaf_wetness_probability_mean(
    Variable.leaf_wetness_probability,
    aggregation: Aggregation.mean,
  ),
  precipitation_probability_mean(
    Variable.precipitation_probability,
    aggregation: Aggregation.mean,
  ),
  precipitation_probability_min(
    Variable.precipitation_probability,
    aggregation: Aggregation.minimum,
  ),
  relative_humidity_2m_mean(
    Variable.relative_humidity,
    aggregation: Aggregation.mean,
    altitude: 2,
  ),
  relative_humidity_2m_max(
    Variable.relative_humidity,
    aggregation: Aggregation.maximum,
    altitude: 2,
  ),
  relative_humidity_2m_min(
    Variable.relative_humidity,
    aggregation: Aggregation.minimum,
    altitude: 2,
  ),
  snowfall_water_equivalent_sum(
    Variable.snowfall_water_equivalent,
    aggregation: Aggregation.sum,
  ),
  pressure_msl_mean(
    Variable.pressure_msl,
    aggregation: Aggregation.mean,
  ),
  pressure_msl_max(
    Variable.pressure_msl,
    aggregation: Aggregation.maximum,
  ),
  pressure_msl_min(
    Variable.pressure_msl,
    aggregation: Aggregation.minimum,
  ),
  surface_pressure_mean(
    Variable.surface_pressure,
    aggregation: Aggregation.mean,
  ),
  surface_pressure_max(
    Variable.surface_pressure,
    aggregation: Aggregation.maximum,
  ),
  surface_pressure_min(
    Variable.surface_pressure,
    aggregation: Aggregation.minimum,
  ),
  updraft_max(
    Variable.updraft,
    aggregation: Aggregation.maximum,
  ),
  visibility_mean(
    Variable.visibility,
    aggregation: Aggregation.mean,
  ),
  visibility_min(
    Variable.visibility,
    aggregation: Aggregation.minimum,
  ),
  visibility_max(
    Variable.visibility,
    aggregation: Aggregation.maximum,
  ),
  winddirection_10m_dominant(
    Variable.wind_direction,
    aggregation: Aggregation.dominant,
    altitude: 10,
  ),
  wind_gusts_10m_mean(
    Variable.wind_gusts,
    aggregation: Aggregation.mean,
    altitude: 10,
  ),
  wind_speed_10m_mean(
    Variable.wind_speed,
    aggregation: Aggregation.mean,
    altitude: 10,
  ),
  wind_gusts_10m_min(
    Variable.wind_gusts,
    aggregation: Aggregation.minimum,
    altitude: 10,
  ),
  wind_speed_10m_min(
    Variable.wind_speed,
    aggregation: Aggregation.minimum,
    altitude: 10,
  ),
  wet_bulb_temperature_2m_mean(
    Variable.wet_bulb_temperature,
    aggregation: Aggregation.mean,
    altitude: 2,
  ),
  wet_bulb_temperature_2m_max(
    Variable.wet_bulb_temperature,
    aggregation: Aggregation.maximum,
    altitude: 2,
  ),
  wet_bulb_temperature_2m_min(
    Variable.wet_bulb_temperature,
    aggregation: Aggregation.minimum,
    altitude: 2,
  ),
  vapour_pressure_deficit_max(
    Variable.vapour_pressure_deficit,
    aggregation: Aggregation.maximum,
  ),
  soil_moisture_0_to_100cm_mean(
    Variable.soil_moisture,
    aggregation: Aggregation.mean,
    depth: 0,
    depthTo: 100,
  ),
  soil_moisture_0_to_10cm_mean(
    Variable.soil_moisture,
    aggregation: Aggregation.mean,
    depth: 0,
    depthTo: 10,
  ),
  soil_moisture_0_to_7cm_mean(
    Variable.soil_moisture,
    aggregation: Aggregation.mean,
    depth: 0,
    depthTo: 7,
  ),
  soil_moisture_28_to_100cm_mean(
    Variable.soil_moisture,
    aggregation: Aggregation.mean,
    depth: 28,
    depthTo: 100,
  ),
  soil_moisture_7_to_28cm_mean(
    Variable.soil_moisture,
    aggregation: Aggregation.mean,
    depth: 7,
    depthTo: 28,
  ),
  soil_temperature_0_to_100cm_mean(
    Variable.soil_temperature,
    aggregation: Aggregation.mean,
    depth: 0,
    depthTo: 100,
  ),
  soil_temperature_0_to_7cm_mean(
    Variable.soil_temperature,
    aggregation: Aggregation.mean,
    depth: 0,
    depthTo: 7,
  ),
  soil_temperature_28_to_100cm_mean(
    Variable.soil_temperature,
    aggregation: Aggregation.mean,
    depth: 28,
    depthTo: 100,
  ),
  soil_temperature_7_to_28cm_mean(
    Variable.soil_temperature,
    aggregation: Aggregation.mean,
    depth: 7,
    depthTo: 28,
  ),
  ;

  @override
  final Variable variable;
  @override
  final int altitude;
  @override
  final int depth;
  @override
  final int depthTo;
  @override
  final Aggregation aggregation;
  const HistoricalDaily(
    this.variable, {
    this.altitude = 0,
    this.depth = 0,
    this.depthTo = 0,
    this.aggregation = Aggregation.none,
  });

  static final Map<int, HistoricalDaily> hashes =
      makeHashes(HistoricalDaily.values);
}
