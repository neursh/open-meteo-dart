import '../api.dart';
import '../enums/weather.dart';
import '../options.dart';
import '../response.dart';

/// Seamless integration of high-resolution weather models with up 16 days forecast.
///
/// https://open-meteo.com/en/docs/
class WeatherApi extends BaseApi {
  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;
  final int? pastDays, pastHours, pastMinutely15;
  final int? forecastDays, forecastHours, forecastMinutely15;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;

  WeatherApi({
    super.apiUrl = 'https://api.open-meteo.com/v1/forecast',
    super.apiKey,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.elevation,
    this.pastDays,
    this.pastHours,
    this.pastMinutely15,
    this.forecastDays,
    this.forecastHours,
    this.forecastMinutely15,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
  });

  WeatherApi copyWith({
    String? apiUrl,
    String? apiKey,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    double? elevation,
    int? pastDays,
    int? pastHours,
    int? pastMinutely15,
    int? forecastDays,
    int? forecastHours,
    int? forecastMinutely15,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startHour,
    DateTime? endHour,
  }) =>
      WeatherApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
        elevation: elevation ?? this.elevation,
        pastDays: pastDays ?? this.pastDays,
        pastHours: pastHours ?? this.pastHours,
        pastMinutely15: pastMinutely15 ?? this.pastMinutely15,
        forecastDays: forecastDays ?? this.forecastDays,
        forecastHours: forecastHours ?? this.forecastHours,
        forecastMinutely15: forecastMinutely15 ?? this.forecastMinutely15,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startHour: startHour ?? this.startHour,
        endHour: endHour ?? this.endHour,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<WeatherHourly>? hourly,
    List<WeatherDaily>? daily,
    List<WeatherCurrent>? current,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          current: current,
        ),
      );

  Future<ApiResponse<WeatherApi>> request({
    required double latitude,
    required double longitude,
    List<WeatherHourly>? hourly,
    List<WeatherDaily>? daily,
    List<WeatherCurrent>? current,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          current: current,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data,
          currentHashes: WeatherCurrent.hashes,
          hourlyHashes: WeatherHourly.hashes,
          dailyHashes: WeatherDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required List<WeatherHourly>? hourly,
    required List<WeatherDaily>? daily,
    required List<WeatherCurrent>? current,
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
        'cell_selection': cellSelection,
        'elevation': elevation,
        'past_days': pastDays,
        'past_hours': pastHours,
        'past_minutely_15': pastMinutely15,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'forecast_minutely_15': forecastMinutely15,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
