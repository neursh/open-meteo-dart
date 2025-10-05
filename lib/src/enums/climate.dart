import '../api.dart';
import '../apis/climate.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

// Generated Variable Enums for Climate

enum ClimateDaily with Parameter<ClimateApi, Daily> {
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
  wind_speed_10m_mean(
    Variable.wind_speed,
    aggregation: Aggregation.mean,
    altitude: 10,
  ),
  wind_speed_10m_max(
    Variable.wind_speed,
    aggregation: Aggregation.maximum,
    altitude: 10,
  ),
  cloud_cover_mean(
    Variable.cloud_cover,
    aggregation: Aggregation.mean,
  ),
  shortwave_radiation_sum(
    Variable.shortwave_radiation,
    aggregation: Aggregation.sum,
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
  dew_point_2m_mean(
    Variable.dew_point,
    aggregation: Aggregation.mean,
    altitude: 2,
  ),
  dew_point_2m_min(
    Variable.dew_point,
    aggregation: Aggregation.minimum,
    altitude: 2,
  ),
  dew_point_2m_max(
    Variable.dew_point,
    aggregation: Aggregation.maximum,
    altitude: 2,
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
  pressure_msl_mean(
    Variable.pressure_msl,
    aggregation: Aggregation.mean,
  ),
  soil_moisture_0_to_10cm_mean(
    Variable.soil_moisture,
    aggregation: Aggregation.mean,
    depth: 0,
    depthTo: 10,
  ),
  et0_fao_evapotranspiration_sum(
    Variable.et0_fao_evapotranspiration,
    aggregation: Aggregation.sum,
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
  const ClimateDaily(
    this.variable, {
    this.altitude = 0,
    this.depth = 0,
    this.depthTo = 0,
    this.aggregation = Aggregation.none,
  });

  static final Map<int, ClimateDaily> hashes = makeHashes(ClimateDaily.values);
}
