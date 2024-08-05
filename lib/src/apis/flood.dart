import '../api.dart';
import '../enums/flood.dart';
import '../options.dart';
import '../response.dart';

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

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<FloodDaily>? daily,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          daily: daily,
        ),
      );

  Future<ApiResponse<FloodApi>> request({
    required double latitude,
    required double longitude,
    List<FloodDaily>? daily,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          daily: daily,
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
    required List<FloodDaily>? daily,
  }) =>
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
