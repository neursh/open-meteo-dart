import '../api.dart';
import '../apis/flood.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Flood's daily variables provided by Open-Meteo.
enum FloodDaily with Parameter<FloodApi, Daily> {
  river_discharge(Variable.river_discharge),
  river_discharge_mean(
    Variable.river_discharge,
    aggregation: Aggregation.mean,
  ),
  river_discharge_median(
    Variable.river_discharge,
    aggregation: Aggregation.median,
  ),
  river_discharge_max(
    Variable.river_discharge,
    aggregation: Aggregation.maximum,
  ),
  river_discharge_min(
    Variable.river_discharge,
    aggregation: Aggregation.minimum,
  ),
  river_discharge_p25(
    Variable.river_discharge,
    aggregation: Aggregation.p25,
  ),
  river_discharge_p75(
    Variable.river_discharge,
    aggregation: Aggregation.p75,
  );

  @override
  final Variable variable;

  @override
  final Aggregation aggregation;

  const FloodDaily(
    this.variable, {
    this.aggregation = Aggregation.none,
  });

  static final Map<int, FloodDaily> hashes = makeHashes(FloodDaily.values);
}
