import '../api.dart';
import '../enums/flood.dart';
import '../options.dart';
import '../response.dart';

/// Simulated river discharge at 5 km resolution from 1984 up to 7 months forecast.
///
/// https://open-meteo.com/en/docs/flood-api/
class FloodApi extends BaseApi {
  final CellSelection cellSelection;
  final bool ensemble;

  const FloodApi({
    super.apiUrl = 'https://flood-api.open-meteo.com/v1/flood',
    super.apiKey,
    this.cellSelection = CellSelection.nearest,
    this.ensemble = false,
  });

  FloodApi copyWith({
    String? apiUrl,
    String? apiKey,
    CellSelection? cellSelection,
    bool? ensemble,
  }) =>
      FloodApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        cellSelection: cellSelection ?? this.cellSelection,
        ensemble: ensemble ?? this.ensemble,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    required Set<FloodDaily> daily,
    int? pastDays,
    int? forecastDays,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          daily: daily,
          pastDays: pastDays,
          forecastDays: forecastDays,
          startDate: startDate,
          endDate: endDate,
        ),
      );

  Future<ApiResponse<FloodApi>> request({
    required double latitude,
    required double longitude,
    required Set<FloodDaily> daily,
    int? pastDays,
    int? forecastDays,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          daily: daily,
          pastDays: pastDays,
          forecastDays: forecastDays,
          startDate: startDate,
          endDate: endDate,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data,
          dailyHashes: FloodDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required Set<FloodDaily> daily,
    required int? pastDays,
    required int? forecastDays,
    required DateTime? startDate,
    required DateTime? endDate,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'daily': daily,
        'cell_selection': nullIfEqual(cellSelection, CellSelection.nearest),
        'ensemble': nullIfEqual(ensemble, false),
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
