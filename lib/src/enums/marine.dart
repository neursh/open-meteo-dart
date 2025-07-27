import '../api.dart';
import '../apis/marine.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

// Generated Variable Enums for Marine

enum MarineMinutely15 with Parameter<MarineApi, Minutely15> {
  ocean_current_velocity(
    Variable.ocean_current_velocity,
  ),
  ocean_current_direction(
    Variable.ocean_current_direction,
  ),
  sea_level_height_msl(
    Variable.sea_level_height_msl,
  ),
  ;

  @override
  final Variable variable;
  const MarineMinutely15(this.variable);

  static final Map<int, MarineMinutely15> hashes =
      makeHashes(MarineMinutely15.values);
}

enum MarineCurrent with Parameter<MarineApi, Current> {
  wave_height(
    Variable.wave_height,
  ),
  wave_direction(
    Variable.wave_direction,
  ),
  wave_period(
    Variable.wave_period,
  ),
  wind_wave_peak_period(
    Variable.wind_wave_peak_period,
  ),
  wind_wave_height(
    Variable.wind_wave_height,
  ),
  wind_wave_direction(
    Variable.wind_wave_direction,
  ),
  wind_wave_period(
    Variable.wind_wave_period,
  ),
  swell_wave_height(
    Variable.swell_wave_height,
  ),
  swell_wave_direction(
    Variable.swell_wave_direction,
  ),
  swell_wave_period(
    Variable.swell_wave_period,
  ),
  swell_wave_peak_period(
    Variable.swell_wave_peak_period,
  ),
  secondary_swell_wave_height(
    Variable.secondary_swell_wave_height,
  ),
  secondary_swell_wave_period(
    Variable.secondary_swell_wave_period,
  ),
  secondary_swell_wave_direction(
    Variable.secondary_swell_wave_direction,
  ),
  // Dunno, the upstream API returns nothing for these ones.
  // tertiary_swell_wave_height(
  //   Variable.tertiary_swell_wave_height,
  // ),
  // tertiary_swell_wave_period(
  //   Variable.tertiary_swell_wave_period,
  // ),
  // tertiary_swell_wave_direction(
  //   Variable.tertiary_swell_wave_direction,
  // ),
  sea_level_height_msl(
    Variable.sea_level_height_msl,
  ),
  sea_surface_temperature(
    Variable.sea_surface_temperature,
  ),
  ocean_current_velocity(
    Variable.ocean_current_velocity,
  ),
  ocean_current_direction(
    Variable.ocean_current_direction,
  ),
  ;

  @override
  final Variable variable;
  const MarineCurrent(this.variable);

  static final Map<int, MarineCurrent> hashes =
      makeHashes(MarineCurrent.values);
}

enum MarineHourly with Parameter<MarineApi, Hourly> {
  wave_height(
    Variable.wave_height,
  ),
  wave_direction(
    Variable.wave_direction,
  ),
  wave_period(
    Variable.wave_period,
  ),
  wind_wave_peak_period(
    Variable.wind_wave_peak_period,
  ),
  wind_wave_height(
    Variable.wind_wave_height,
  ),
  wind_wave_direction(
    Variable.wind_wave_direction,
  ),
  wind_wave_period(
    Variable.wind_wave_period,
  ),
  swell_wave_height(
    Variable.swell_wave_height,
  ),
  swell_wave_direction(
    Variable.swell_wave_direction,
  ),
  swell_wave_period(
    Variable.swell_wave_period,
  ),
  swell_wave_peak_period(
    Variable.swell_wave_peak_period,
  ),
  secondary_swell_wave_height(
    Variable.secondary_swell_wave_height,
  ),
  secondary_swell_wave_period(
    Variable.secondary_swell_wave_period,
  ),
  secondary_swell_wave_direction(
    Variable.secondary_swell_wave_direction,
  ),
  tertiary_swell_wave_height(
    Variable.tertiary_swell_wave_height,
  ),
  tertiary_swell_wave_period(
    Variable.tertiary_swell_wave_period,
  ),
  tertiary_swell_wave_direction(
    Variable.tertiary_swell_wave_direction,
  ),
  sea_level_height_msl(
    Variable.sea_level_height_msl,
  ),
  sea_surface_temperature(
    Variable.sea_surface_temperature,
  ),
  ocean_current_velocity(
    Variable.ocean_current_velocity,
  ),
  ocean_current_direction(
    Variable.ocean_current_direction,
  ),
  invert_barometer_height(
    Variable.invert_barometer_height,
  ),
  ;

  @override
  final Variable variable;
  const MarineHourly(this.variable);

  static final Map<int, MarineHourly> hashes = makeHashes(MarineHourly.values);
}

enum MarineDaily with Parameter<MarineApi, Daily> {
  wave_height_max(
    Variable.wave_height,
    aggregation: Aggregation.maximum,
  ),
  wave_direction_dominant(
    Variable.wave_direction,
    aggregation: Aggregation.dominant,
  ),
  wave_period_max(
    Variable.wave_period,
    aggregation: Aggregation.maximum,
  ),
  wind_wave_height_max(
    Variable.wind_wave_height,
    aggregation: Aggregation.maximum,
  ),
  wind_wave_direction_dominant(
    Variable.wind_wave_direction,
    aggregation: Aggregation.dominant,
  ),
  wind_wave_period_max(
    Variable.wind_wave_period,
    aggregation: Aggregation.maximum,
  ),
  wind_wave_peak_period_max(
    Variable.wind_wave_peak_period,
    aggregation: Aggregation.maximum,
  ),
  swell_wave_height_max(
    Variable.swell_wave_height,
    aggregation: Aggregation.maximum,
  ),
  swell_wave_direction_dominant(
    Variable.swell_wave_direction,
    aggregation: Aggregation.dominant,
  ),
  swell_wave_period_max(
    Variable.swell_wave_period,
    aggregation: Aggregation.maximum,
  ),
  swell_wave_peak_period_max(
    Variable.swell_wave_peak_period,
    aggregation: Aggregation.maximum,
  ),
  ;

  @override
  final Variable variable;
  @override
  final Aggregation aggregation;
  const MarineDaily(
    this.variable, {
    this.aggregation = Aggregation.none,
  });

  static final Map<int, MarineDaily> hashes = makeHashes(MarineDaily.values);
}
