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

  WeatherApi({
    super.apiUrl = 'https://api.open-meteo.com/v1/forecast',
    super.apiKey,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.elevation,
  });

  WeatherApi copyWith({
    String? apiUrl,
    String? apiKey,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    double? elevation,
  }) =>
      WeatherApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
        elevation: elevation ?? this.elevation,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<WeatherHourly>? hourly,
    List<WeatherDaily>? daily,
    List<WeatherCurrent>? current,
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
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          current: current,
          pastDays: pastDays,
          pastHours: pastHours,
          pastMinutely15: pastMinutely15,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          forecastMinutely15: forecastMinutely15,
          startDate: startDate,
          endDate: endDate,
          startHour: startHour,
          endHour: endHour,
        ),
      );

  Future<ApiResponse<WeatherApi>> request({
    required double latitude,
    required double longitude,
    List<WeatherHourly>? hourly,
    List<WeatherDaily>? daily,
    List<WeatherCurrent>? current,
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
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          current: current,
          pastDays: pastDays,
          pastHours: pastHours,
          pastMinutely15: pastMinutely15,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          forecastMinutely15: forecastMinutely15,
          startDate: startDate,
          endDate: endDate,
          startHour: startHour,
          endHour: endHour,
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
    required int? pastDays,
    required int? pastHours,
    required int? pastMinutely15,
    required int? forecastDays,
    required int? forecastHours,
    required int? forecastMinutely15,
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
