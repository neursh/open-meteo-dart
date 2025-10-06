import '../api.dart';
import '../enums/historical.dart';
import '../options.dart';
import '../response.dart';

/// Discover how weather has shaped our world from 1940 until now.
///
/// https://open-meteo.com/en/docs/historical-weather-api/
class HistoricalApi extends BaseApi {
  final TemperatureUnit temperatureUnit;
  final WindspeedUnit windspeedUnit;
  final PrecipitationUnit precipitationUnit;
  final CellSelection cellSelection;

  const HistoricalApi({
    super.apiUrl = 'https://archive-api.open-meteo.com/v1/archive',
    super.apiKey,
    super.userAgent,
    this.temperatureUnit = TemperatureUnit.celsius,
    this.windspeedUnit = WindspeedUnit.kmh,
    this.precipitationUnit = PrecipitationUnit.mm,
    this.cellSelection = CellSelection.land,
  });

  HistoricalApi copyWith(
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    double? elevation,
  ) =>
      HistoricalApi(
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
    required Set<double> latitude,
    required Set<double> longitude,
    required DateTime startDate,
    required DateTime endDate,
    Set<HistoricalHourly> hourly = const {},
    Set<HistoricalDaily> daily = const {},
    double? elevation,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          startDate: startDate,
          endDate: endDate,
          hourly: hourly,
          daily: daily,
          elevation: elevation,
        ),
      );

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
  Future<ApiResponse<HistoricalApi>> request({
    required Set<double> latitude,
    required Set<double> longitude,
    required DateTime startDate,
    required DateTime endDate,
    Set<HistoricalHourly> hourly = const {},
    Set<HistoricalDaily> daily = const {},
    double? elevation,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          startDate: startDate,
          endDate: endDate,
          hourly: hourly,
          daily: daily,
          elevation: elevation,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data.$1,
          data.$2,
          hourlyHashes: HistoricalHourly.hashes,
          dailyHashes: HistoricalDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required Set<double> latitude,
    required Set<double> longitude,
    required DateTime startDate,
    required DateTime endDate,
    required Set<HistoricalHourly> hourly,
    required Set<HistoricalDaily> daily,
    required double? elevation,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'hourly': nullIfEmpty(hourly),
        'daily': nullIfEmpty(daily),
        'temperature_unit':
            nullIfEqual(temperatureUnit, TemperatureUnit.celsius),
        'windspeed_unit': nullIfEqual(windspeedUnit, WindspeedUnit.kmh),
        'precipitaion_unit':
            nullIfEqual(precipitationUnit, PrecipitationUnit.mm),
        'cell_selection': nullIfEqual(cellSelection, CellSelection.land),
        'elevation': elevation,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
