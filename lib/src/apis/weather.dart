import '../api.dart';
import '../enums/weather.dart';
import '../options.dart';
import '../response.dart';

/// Seamless integration of high-resolution weather models with up 16 days forecast.
///
/// https://open-meteo.com/en/docs/
class WeatherApi extends BaseApi {
  final TemperatureUnit temperatureUnit;
  final WindspeedUnit windspeedUnit;
  final PrecipitationUnit precipitationUnit;
  final CellSelection cellSelection;

  const WeatherApi({
    super.apiUrl = 'https://api.open-meteo.com/v1/forecast',
    super.apiKey,
    super.userAgent,
    this.temperatureUnit = TemperatureUnit.celsius,
    this.windspeedUnit = WindspeedUnit.kmh,
    this.precipitationUnit = PrecipitationUnit.mm,
    this.cellSelection = CellSelection.land,
  });

  WeatherApi copyWith({
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
  }) =>
      WeatherApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  /// This method exists solely for debug purposes, do not use in production.
  /// Use `request()` instead.
  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    Set<WeatherHourly> hourly = const {},
    Set<WeatherDaily> daily = const {},
    Set<WeatherCurrent> current = const {},
    Set<WeatherMinutely15> minutely15 = const {},
    Set<WeatherModel> models = const {},
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
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          minutely15: minutely15,
          current: current,
          models: models,
          elevation: elevation,
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

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
  Future<ApiResponse<WeatherApi>> request({
    required double latitude,
    required double longitude,
    Set<WeatherHourly> hourly = const {},
    Set<WeatherDaily> daily = const {},
    Set<WeatherCurrent> current = const {},
    Set<WeatherMinutely15> minutely15 = const {},
    Set<WeatherModel> models = const {},
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
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
          daily: daily,
          current: current,
          minutely15: minutely15,
          models: models,
          elevation: elevation,
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
          data.$1,
          data.$2,
          minutely15Hashes: WeatherMinutely15.hashes,
          currentHashes: WeatherCurrent.hashes,
          hourlyHashes: WeatherHourly.hashes,
          dailyHashes: WeatherDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required Set<WeatherHourly> hourly,
    required Set<WeatherDaily> daily,
    required Set<WeatherCurrent> current,
    required Set<WeatherMinutely15> minutely15,
    required Set<WeatherModel> models,
    required double? elevation,
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
        'minutely_15': nullIfEmpty(minutely15),
        'current': nullIfEmpty(current),
        'hourly': nullIfEmpty(hourly),
        'daily': nullIfEmpty(daily),
        'models': nullIfEmpty(models),
        'temperature_unit':
            nullIfEqual(temperatureUnit, TemperatureUnit.celsius),
        'windspeed_unit': nullIfEqual(windspeedUnit, WindspeedUnit.kmh),
        'precipitation_unit':
            nullIfEqual(precipitationUnit, PrecipitationUnit.mm),
        'cell_selection': nullIfEqual(cellSelection, CellSelection.land),
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
