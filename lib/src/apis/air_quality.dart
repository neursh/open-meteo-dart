import '../api.dart';
import '../enums/air_quality.dart';
import '../options.dart';
import '../response.dart';

/// Pollutants and pollen forecast in 11 km resolution.
///
/// https://open-meteo.com/en/docs/air-quality-api/
class AirQualityApi extends BaseApi {
  final CellSelection? cellSelection;
  final AirQualityDomains? domains;

  AirQualityApi({
    super.apiUrl = 'https://air-quality-api.open-meteo.com/v1/air-quality',
    super.apiKey,
    this.cellSelection,
    this.domains,
  });

  AirQualityApi copyWith({
    String? apiUrl,
    String? apiKey,
    CellSelection? cellSelection,
    AirQualityDomains? domains,
  }) =>
      AirQualityApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        cellSelection: cellSelection ?? this.cellSelection,
        domains: domains ?? this.domains,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<AirQualityHourly>? hourly,
    List<AirQualityCurrent>? current,
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

  Future<ApiResponse<AirQualityApi>> request({
    required double latitude,
    required double longitude,
    List<AirQualityHourly>? hourly,
    List<AirQualityCurrent>? current,
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
          data,
          hourlyHashes: AirQualityHourly.hashes,
          currentHashes: AirQualityCurrent.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required List<AirQualityHourly>? hourly,
    required List<AirQualityCurrent>? current,
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
        'hourly': hourly,
        'current': current,
        'domains': domains,
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'past_hours': pastHours,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'call_selection': cellSelection,
        'apikey': apiKey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
