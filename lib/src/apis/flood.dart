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
    super.userAgent,
    this.cellSelection = CellSelection.nearest,
    this.ensemble = false,
  });

  FloodApi copyWith({
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    CellSelection? cellSelection,
    bool? ensemble,
  }) =>
      FloodApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        cellSelection: cellSelection ?? this.cellSelection,
        ensemble: ensemble ?? this.ensemble,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  /// This method exists solely for debug purposes, do not use in production.
  /// Use `request()` instead.
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

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
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
          data.$1,
          data.$2,
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
