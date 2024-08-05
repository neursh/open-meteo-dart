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
    this.temperatureUnit = TemperatureUnit.celsius,
    this.windspeedUnit = WindspeedUnit.kmh,
    this.precipitationUnit = PrecipitationUnit.mm,
    this.cellSelection = CellSelection.land,
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
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
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

  Future<ApiResponse<HistoricalApi>> request({
    required double latitude,
    required double longitude,
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
    required Set<HistoricalHourly> hourly,
    required Set<HistoricalDaily> daily,
    required double? elevation,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'hourly': nullIfEqual<Set>(hourly, const {}),
        'daily': nullIfEqual<Set>(daily, const {}),
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
