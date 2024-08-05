import '../api.dart';
import '../enums/marine.dart';
import '../options.dart';
import '../response.dart';

/// Hourly wave forecasts at 5 km resolution
///
/// https://open-meteo.com/en/docs/marine-weather-api/
class MarineApi extends BaseApi {
  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final LengthUnit? lengthUnit;
  final CellSelection? cellSelection;

  MarineApi({
    super.apiUrl = 'https://marine-api.open-meteo.com/v1/marine',
    super.apiKey,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.lengthUnit,
    this.cellSelection,
  });

  MarineApi copyWith({
    String? apiUrl,
    String? apiKey,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    LengthUnit? lengthUnit,
    CellSelection? cellSelection,
  }) =>
      MarineApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        lengthUnit: lengthUnit ?? this.lengthUnit,
        cellSelection: cellSelection ?? this.cellSelection,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<MarineCurrent>? current,
    List<MarineHourly>? hourly,
    List<MarineDaily>? daily,
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
          current: current,
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

  Future<ApiResponse<MarineApi>> request({
    required double latitude,
    required double longitude,
    List<MarineCurrent>? current,
    List<MarineHourly>? hourly,
    List<MarineDaily>? daily,
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
          current: current,
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
          data,
          currentHashes: MarineCurrent.hashes,
          hourlyHashes: MarineHourly.hashes,
          dailyHashes: MarineDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required List<MarineCurrent>? current,
    required List<MarineHourly>? hourly,
    required List<MarineDaily>? daily,
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
        'current': current,
        'hourly': hourly,
        'daily': daily,
        'temperature_unit': temperatureUnit,
        'windspeed_unit': windspeedUnit,
        'precipitation_unit': precipitationUnit,
        'length_unit': lengthUnit,
        'cell_selection': cellSelection,
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
