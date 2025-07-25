import '../api.dart';
import '../enums/satellite.dart';
import '../options.dart';
import '../response.dart';

/// Hourly wave forecasts at 5 km resolution
///
/// https://open-meteo.com/en/docs/marine-weather-api/
class SatelliteApi extends BaseApi {
  final int tilt;
  final int azimuth;
  final CellSelection cellSelection;

  const SatelliteApi({
    super.apiUrl = 'https://satellite-api.open-meteo.com/v1/archive',
    super.apiKey,
    this.tilt = 0,
    this.azimuth = 0,
    this.cellSelection = CellSelection.sea,
  });

  SatelliteApi copyWith({
    String? apiUrl,
    String? apiKey,
    int? tilt,
    int? azimuth,
    CellSelection? cellSelection,
  }) =>
      SatelliteApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        tilt: tilt ?? this.tilt,
        azimuth: azimuth ?? this.azimuth,
        cellSelection: cellSelection ?? this.cellSelection,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  /// This method exists solely for debug purposes, do not use in production.
  /// Use `request()` instead.
  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    Set<SatelliteHourly> hourly = const {},
    Set<SatelliteDaily> daily = const {},
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
          daily: daily,
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
  Future<ApiResponse<SatelliteApi>> request({
    required double latitude,
    required double longitude,
    Set<SatelliteHourly> hourly = const {},
    Set<SatelliteDaily> daily = const {},
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
          daily: daily,
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
          hourlyHashes: SatelliteHourly.hashes,
          dailyHashes: SatelliteDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required Set<SatelliteHourly> hourly,
    required Set<SatelliteDaily> daily,
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
        'hourly': nullIfEmpty(hourly),
        'daily': nullIfEmpty(daily),
        'tilt': nullIfEqual(tilt, 0),
        'azimuth': nullIfEqual(azimuth, 0),
        'cell_selection': nullIfEqual(cellSelection, CellSelection.sea),
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
