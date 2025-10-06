import '../api.dart';
import '../enums/satellite_radiation.dart';
import '../options.dart';
import '../response.dart';
import '../model_export.dart';

/// Hourly wave forecasts at 5 km resolution
///
/// https://open-meteo.com/en/docs/marine-weather-api/
class SatelliteRadiationApi extends BaseApi {
  final Set<OpenMeteoModel> models;
  final int tilt;
  final int azimuth;
  final CellSelection cellSelection;

  const SatelliteRadiationApi({
    super.apiUrl = 'https://satellite-api.open-meteo.com/v1/archive',
    super.apiKey,
    super.userAgent,
    required this.models,
    this.tilt = 0,
    this.azimuth = 0,
    this.cellSelection = CellSelection.sea,
  });

  SatelliteRadiationApi copyWith({
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    Set<OpenMeteoModel>? models,
    int? tilt,
    int? azimuth,
    CellSelection? cellSelection,
  }) =>
      SatelliteRadiationApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        models: models ?? this.models,
        tilt: tilt ?? this.tilt,
        azimuth: azimuth ?? this.azimuth,
        cellSelection: cellSelection ?? this.cellSelection,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  /// This method exists solely for debug purposes, do not use in production.
  /// Use `request()` instead.
  Future<Map<String, dynamic>> requestJson({
    required Set<double> latitude,
    required Set<double> longitude,
    Set<SatelliteRadiationHourly> hourly = const {},
    Set<SatelliteRadiationDaily> daily = const {},
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
  Future<ApiResponse<SatelliteRadiationApi>> request({
    required Set<double> latitude,
    required Set<double> longitude,
    Set<SatelliteRadiationHourly> hourly = const {},
    Set<SatelliteRadiationDaily> daily = const {},
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
          hourlyHashes: SatelliteRadiationHourly.hashes,
          dailyHashes: SatelliteRadiationDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required Set<double> latitude,
    required Set<double> longitude,
    required Set<SatelliteRadiationHourly> hourly,
    required Set<SatelliteRadiationDaily> daily,
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
        'models': models,
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
