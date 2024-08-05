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

  final int? pastDays, pastHours;
  final int? forecastDays, forecastHours;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;

  AirQualityApi({
    super.apiUrl = 'https://air-quality-api.open-meteo.com/v1/air-quality',
    super.apiKey,
    this.cellSelection,
    this.domains,
    this.pastDays,
    this.pastHours,
    this.forecastDays,
    this.forecastHours,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
  });

  AirQualityApi copyWith({
    String? apiUrl,
    String? apiKey,
    CellSelection? cellSelection,
    AirQualityDomains? domains,
    int? pastDays,
    int? pastHours,
    int? forecastDays,
    int? forecastHours,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startHour,
    DateTime? endHour,
  }) =>
      AirQualityApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        cellSelection: cellSelection ?? this.cellSelection,
        domains: domains ?? this.domains,
        pastDays: pastDays ?? this.pastDays,
        pastHours: pastHours ?? this.pastHours,
        forecastDays: forecastDays ?? this.forecastDays,
        forecastHours: forecastHours ?? this.forecastHours,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startHour: startHour ?? this.startHour,
        endHour: endHour ?? this.endHour,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<AirQualityHourly>? hourly,
    List<AirQualityCurrent>? current,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          current: current,
        ),
      );

  Future<ApiResponse<AirQualityApi>> request({
    required double latitude,
    required double longitude,
    List<AirQualityHourly>? hourly,
    List<AirQualityCurrent>? current,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          current: current,
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
