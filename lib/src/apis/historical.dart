import '../api.dart';
import '../enums/historical.dart';
import '../options.dart';
import '../response.dart';

/// Discover how weather has shaped our world from 1940 until now.
///
/// https://open-meteo.com/en/docs/historical-weather-api/
class HistoricalApi extends BaseApi {
  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;

  HistoricalApi({
    super.apiUrl = 'https://archive-api.open-meteo.com/v1/archive',
    super.apiKey,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.elevation,
  });

  HistoricalApi copyWith(
    String? apiUrl,
    String? apiKey,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    double? elevation,
  ) =>
      HistoricalApi(
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
    required DateTime startDate,
    required DateTime endDate,
    List<HistoricalHourly>? hourly,
    List<HistoricalDaily>? daily,
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
        ),
      );

  Future<ApiResponse<HistoricalApi>> request({
    required double latitude,
    required double longitude,
    required DateTime startDate,
    required DateTime endDate,
    List<HistoricalHourly>? hourly,
    List<HistoricalDaily>? daily,
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
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data,
          hourlyHashes: HistoricalHourly.hashes,
          dailyHashes: HistoricalDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required DateTime startDate,
    required DateTime endDate,
    required List<HistoricalHourly>? hourly,
    required List<HistoricalDaily>? daily,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'hourly': hourly,
        'daily': daily,
        'temperature_unit': temperatureUnit,
        'windspeed_unit': windspeedUnit,
        'precipitaion_unit': precipitationUnit,
        'cell_selection': cellSelection,
        'elevation': elevation,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
