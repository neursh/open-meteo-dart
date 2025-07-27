import '../api.dart';
import '../enums/air_quality.dart';
import '../options.dart';
import '../response.dart';

/// Pollutants and pollen forecast in 11 km resolution.
///
/// https://open-meteo.com/en/docs/air-quality-api/
class AirQualityApi extends BaseApi {
  final CellSelection cellSelection;
  final AirQualityDomains domains;
  const AirQualityApi({
    super.apiUrl = 'https://air-quality-api.open-meteo.com/v1/air-quality',
    super.apiKey,
    super.userAgent,
    this.cellSelection = CellSelection.nearest,
    this.domains = AirQualityDomains.auto,
  });

  AirQualityApi copyWith({
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    CellSelection? cellSelection,
    AirQualityDomains? domains,
  }) =>
      AirQualityApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        cellSelection: cellSelection ?? this.cellSelection,
        domains: domains ?? this.domains,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  /// This method exists solely for debug purposes, do not use in production.
  /// Use `request()` instead.
  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    Set<AirQualityHourly> hourly = const {},
    Set<AirQualityCurrent> current = const {},
    int? pastDays,
    int? pastHours,
    int? forecastDays,
    int? forecastHours,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startHour,
    DateTime? endHour,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          current: current,
          pastDays: pastDays,
          pastHours: pastHours,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          startDate: startDate,
          endDate: endDate,
          startHour: startHour,
          endHour: endHour,
        ),
      );

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
  Future<ApiResponse<AirQualityApi>> request({
    required double latitude,
    required double longitude,
    Set<AirQualityHourly> hourly = const {},
    Set<AirQualityCurrent> current = const {},
    int? pastDays,
    int? pastHours,
    int? forecastDays,
    int? forecastHours,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startHour,
    DateTime? endHour,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          current: current,
          pastDays: pastDays,
          pastHours: pastHours,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          startDate: startDate,
          endDate: endDate,
          startHour: startHour,
          endHour: endHour,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data.$1,
          data.$2,
          hourlyHashes: AirQualityHourly.hashes,
          currentHashes: AirQualityCurrent.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required Set<AirQualityHourly> hourly,
    required Set<AirQualityCurrent> current,
    required int? pastDays,
    required int? pastHours,
    required int? forecastDays,
    required int? forecastHours,
    required DateTime? startDate,
    required DateTime? endDate,
    required DateTime? startHour,
    required DateTime? endHour,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'call_selection': nullIfEqual(cellSelection, CellSelection.nearest),
        'domains': nullIfEqual(domains, AirQualityDomains.auto),
        'hourly': nullIfEmpty(hourly),
        'current': nullIfEmpty(current),
        'past_days': pastDays,
        'past_hours': pastHours,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
