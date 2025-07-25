import '../api.dart';
import '../apis/satellite.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

// Generated Variable Enums for Satellite

enum SatelliteHourly with Parameter<SatelliteApi, Hourly> {
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
  is_day(
    Variable.is_day,
  ),
  sunshine_duration(
    Variable.sunshine_duration,
  ),
  ;

  @override
  final Variable variable;
  const SatelliteHourly(this.variable);

  static final Map<int, SatelliteHourly> hashes =
      makeHashes(SatelliteHourly.values);
}

enum SatelliteDaily with Parameter<SatelliteApi, Daily> {
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
  shortwave_radiation_sum(
    Variable.shortwave_radiation,
    aggregation: Aggregation.sum,
  ),
  ;

  @override
  final Variable variable;
  @override
  final Aggregation aggregation;
  const SatelliteDaily(
    this.variable, {
    this.aggregation = Aggregation.none,
  });

  static final Map<int, SatelliteDaily> hashes =
      makeHashes(SatelliteDaily.values);
}
