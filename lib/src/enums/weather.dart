import '../api.dart';
import '../apis/weather.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

// Generated Variable Enums for Weather

enum WeatherMinutely15 with Parameter<WeatherApi, Minutely15> {
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
  snowfall_height(
    Variable.snowfall_height,
  ),
  freezing_level_height(
    Variable.freezing_level_height,
  ),
  sunshine_duration(
    Variable.sunshine_duration,
  ),
  weather_code(
    Variable.weather_code,
  ),
  wind_speed_10m(
    Variable.wind_speed,
    altitude: 10,
  ),
  wind_speed_80m(
    Variable.wind_speed,
    altitude: 80,
  ),
  wind_direction_10m(
    Variable.wind_direction,
    altitude: 10,
  ),
  wind_direction_80m(
    Variable.wind_direction,
    altitude: 80,
  ),
  wind_gusts_10m(
    Variable.wind_gusts,
    altitude: 10,
  ),
  visibility(
    Variable.visibility,
  ),
  cape(
    Variable.cape,
  ),
  lightning_potential(
    Variable.lightning_potential,
  ),
  is_day(
    Variable.is_day,
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
  ;

  @override
  final Variable variable;
  @override
  final int altitude;
  const WeatherMinutely15(
    this.variable, {
    this.altitude = 0,
  });

  static final Map<int, WeatherMinutely15> hashes =
      makeHashes(WeatherMinutely15.values);
}

enum WeatherCurrent with Parameter<WeatherApi, Current> {
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
  is_day(
    Variable.is_day,
  ),
  precipitation(
    Variable.precipitation,
  ),
  rain(
    Variable.rain,
  ),
  showers(
    Variable.showers,
  ),
  snowfall(
    Variable.snowfall,
  ),
  weather_code(
    Variable.weather_code,
  ),
  cloud_cover(
    Variable.cloud_cover,
  ),
  pressure_msl(
    Variable.pressure_msl,
  ),
  surface_pressure(
    Variable.surface_pressure,
  ),
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
  ),
  ;

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

enum WeatherHourly with Parameter<WeatherApi, Hourly> {
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
  precipitation_probability(
    Variable.precipitation_probability,
  ),
  precipitation(
    Variable.precipitation,
  ),
  rain(
    Variable.rain,
  ),
  showers(
    Variable.showers,
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
  visibility(
    Variable.visibility,
  ),
  evapotranspiration(
    Variable.evapotranspiration,
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
  uv_index(
    Variable.uv_index,
  ),
  uv_index_clear_sky(
    Variable.uv_index_clear_sky,
  ),
  is_day(
    Variable.is_day,
  ),
  sunshine_duration(
    Variable.sunshine_duration,
  ),
  wet_bulb_temperature_2m(
    Variable.wet_bulb_temperature,
    altitude: 2,
  ),
  total_column_integrated_water_vapour(
    Variable.total_column_integrated_water_vapour,
  ),
  cape(
    Variable.cape,
  ),
  lifted_index(
    Variable.lifted_index,
  ),
  convective_inhibition(
    Variable.convective_inhibition,
  ),
  freezing_level_height(
    Variable.freezing_level_height,
  ),
  boundary_layer_height(
    Variable.boundary_layer_height,
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
  ;

  @override
  final Variable variable;
  @override
  final int altitude;
  @override
  final int depth;
  @override
  final int depthTo;
  const WeatherHourly(
    this.variable, {
    this.altitude = 0,
    this.depth = 0,
    this.depthTo = 0,
  });

  static final Map<int, WeatherHourly> hashes =
      makeHashes(WeatherHourly.values);
}

enum WeatherDaily with Parameter<WeatherApi, Daily> {
  weather_code(
    Variable.weather_code,
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
  uv_index_max(
    Variable.uv_index,
    aggregation: Aggregation.maximum,
  ),
  uv_index_clear_sky_max(
    Variable.uv_index_clear_sky,
    aggregation: Aggregation.maximum,
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
  precipitation_sum(
    Variable.precipitation,
    aggregation: Aggregation.sum,
  ),
  precipitation_hours(
    Variable.precipitation_hours,
  ),
  precipitation_probability_max(
    Variable.precipitation_probability,
    aggregation: Aggregation.maximum,
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
  temperature_2m_mean(
    Variable.temperature,
    aggregation: Aggregation.mean,
    altitude: 2,
  ),
  apparent_temperature_mean(
    Variable.apparent_temperature,
    aggregation: Aggregation.mean,
    altitude: 2,
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
  ;

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
