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
    required Set<OpenMeteoLocation> locations,
    required Set<FloodDaily> daily,
    int? pastDays,
    int? forecastDays,
    Uri Function(Uri)? overrideUri,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          locations: locations,
          daily: daily,
          pastDays: pastDays,
          forecastDays: forecastDays,
        ),
        overrideUri,
      );

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
  Future<ApiResponse<FloodApi>> request({
    required Set<OpenMeteoLocation> locations,
    required Set<FloodDaily> daily,
    int? pastDays,
    int? forecastDays,
    Uri Function(Uri)? overrideUri,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          locations: locations,
          daily: daily,
          pastDays: pastDays,
          forecastDays: forecastDays,
        ),
        overrideUri,
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data.$1,
          data.$2,
          dailyHashes: FloodDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required Set<OpenMeteoLocation> locations,
    required Set<FloodDaily> daily,
    required int? pastDays,
    required int? forecastDays,
  }) {
    final parsedLocations = parseLocations(locations);
    return {
      'latitude': parsedLocations.latitude,
      'longitude': parsedLocations.longitude,
      'elevation': nullIfEmpty(parsedLocations.elevation),
      'daily': daily,
      'cell_selection': nullIfEqual(cellSelection, CellSelection.nearest),
      'ensemble': nullIfEqual(ensemble, false),
      'past_days': pastDays,
      'forecast_days': forecastDays,
      'start_date': nullIfEmpty(parsedLocations.startDate),
      'end_date': nullIfEmpty(parsedLocations.endDate),
      'timeformat': 'unixtime',
      'timezone': 'auto',
    };
  }
}
