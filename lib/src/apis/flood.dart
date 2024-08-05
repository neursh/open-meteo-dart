import '../api.dart';
import '../options.dart';
import '../response.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Simulated river discharge at 5 km resolution from 1984 up to 7 months forecast.
///
/// https://open-meteo.com/en/docs/flood-api/
class FloodApi extends BaseApi {
  final CellSelection? cellSelection;

  final bool? ensemble;

  final int? pastDays, forecastDays;

  final DateTime? startDate, endDate;

  FloodApi({
    super.apiUrl = 'https://flood-api.open-meteo.com/v1/flood',
    super.apiKey,
    this.cellSelection,
    this.pastDays,
    this.forecastDays,
    this.ensemble,
    this.startDate,
    this.endDate,
  });

  FloodApi copyWith({
    String? apiUrl,
    String? apiKey,
    CellSelection? cellSelection,
    int? pastDays,
    int? forecastDays,
    bool? ensemble,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      FloodApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        cellSelection: cellSelection ?? this.cellSelection,
        pastDays: pastDays ?? this.pastDays,
        forecastDays: forecastDays ?? this.forecastDays,
        ensemble: ensemble ?? this.ensemble,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  Future<Map<String, dynamic>> rawRequest({
    required double latitude,
    required double longitude,
    List<FloodDaily>? daily,
  }) =>
      requestJson(this, _queryParamMap(latitude, longitude, daily));

  Future<ApiResponse<FloodApi>> request({
    required double latitude,
    required double longitude,
    List<FloodDaily>? daily,
  }) =>
      requestFlatBuffer(this, _queryParamMap(latitude, longitude, daily))
          .then((data) => ApiResponse.fromFlatBuffer(
                data,
                dailyHashes: FloodDaily.hashes,
              ));

  Map<String, dynamic> _queryParamMap(
    double latitude,
    double longitude,
    List<FloodDaily>? daily,
  ) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'daily': daily?.map((option) => option.name),
        'cell_selection': cellSelection?.name,
        'ensemble': ensemble,
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

enum FloodDaily with WeatherParameter<FloodApi, Daily> {
  river_discharge(Variable.river_discharge),
  river_discharge_mean(Variable.river_discharge, aggregation: Aggregation.mean),
  river_discharge_median(Variable.river_discharge,
      aggregation: Aggregation.median),
  river_discharge_max(Variable.river_discharge,
      aggregation: Aggregation.maximum),
  river_discharge_min(Variable.river_discharge,
      aggregation: Aggregation.minimum),
  river_discharge_p25(Variable.river_discharge, aggregation: Aggregation.p25),
  river_discharge_p75(Variable.river_discharge, aggregation: Aggregation.p75);

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
