import '../api.dart';
import '../enums/marine.dart';
import '../options.dart';
import '../response.dart';

/// Hourly wave forecasts at 5 km resolution
///
/// https://open-meteo.com/en/docs/marine-weather-api/
class MarineApi extends BaseApi {
  final TemperatureUnit temperatureUnit;
  final WindspeedUnit windspeedUnit;
  final PrecipitationUnit precipitationUnit;
  final LengthUnit lengthUnit;
  final CellSelection cellSelection;

  const MarineApi({
    super.apiUrl = 'https://marine-api.open-meteo.com/v1/marine',
    super.apiKey,
    super.userAgent,
    this.temperatureUnit = TemperatureUnit.celsius,
    this.windspeedUnit = WindspeedUnit.kmh,
    this.precipitationUnit = PrecipitationUnit.mm,
    this.lengthUnit = LengthUnit.metric,
    this.cellSelection = CellSelection.sea,
  });

  MarineApi copyWith({
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    LengthUnit? lengthUnit,
    CellSelection? cellSelection,
  }) =>
      MarineApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        lengthUnit: lengthUnit ?? this.lengthUnit,
        cellSelection: cellSelection ?? this.cellSelection,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  /// This method exists solely for debug purposes, do not use in production.
  /// Use `request()` instead.
  Future<Map<String, dynamic>> requestJson({
    required Set<OpenMeteoLocation> locations,
    Set<MarineCurrent> current = const {},
    Set<MarineHourly> hourly = const {},
    Set<MarineDaily> daily = const {},
    int? pastDays,
    int? pastHours,
    int? forecastDays,
    int? forecastHours,
    DateTime? startHour,
    DateTime? endHour,
    Uri Function(Uri)? overrideUri,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          locations: locations,
          current: current,
          hourly: hourly,
          daily: daily,
          pastDays: pastDays,
          pastHours: pastHours,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          startHour: startHour,
          endHour: endHour,
        ),
        overrideUri,
      );

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
  Future<ApiResponse<MarineApi>> request({
    required Set<OpenMeteoLocation> locations,
    Set<MarineCurrent> current = const {},
    Set<MarineHourly> hourly = const {},
    Set<MarineDaily> daily = const {},
    int? pastDays,
    int? pastHours,
    int? forecastDays,
    int? forecastHours,
    DateTime? startHour,
    DateTime? endHour,
    Uri Function(Uri)? overrideUri,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          locations: locations,
          current: current,
          hourly: hourly,
          daily: daily,
          pastDays: pastDays,
          pastHours: pastHours,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          startHour: startHour,
          endHour: endHour,
        ),
        overrideUri,
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data.$1,
          data.$2,
          currentHashes: MarineCurrent.hashes,
          hourlyHashes: MarineHourly.hashes,
          dailyHashes: MarineDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required Set<OpenMeteoLocation> locations,
    required Set<MarineCurrent> current,
    required Set<MarineHourly> hourly,
    required Set<MarineDaily> daily,
    required int? pastDays,
    required int? pastHours,
    required int? forecastDays,
    required int? forecastHours,
    required DateTime? startHour,
    required DateTime? endHour,
  }) {
    final parsedLocations = parseLocations(locations);
    return {
      'latitude': parsedLocations.latitude,
      'longitude': parsedLocations.longitude,
      'elevation': nullIfEmpty(parsedLocations.elevation),
      'current': nullIfEmpty(current),
      'hourly': nullIfEmpty(hourly),
      'daily': nullIfEmpty(daily),
      'temperature_unit': nullIfEqual(temperatureUnit, TemperatureUnit.celsius),
      'windspeed_unit': nullIfEqual(windspeedUnit, WindspeedUnit.kmh),
      'precipitation_unit':
          nullIfEqual(precipitationUnit, PrecipitationUnit.mm),
      'length_unit': nullIfEqual(lengthUnit, LengthUnit.metric),
      'cell_selection': nullIfEqual(cellSelection, CellSelection.sea),
      'past_days': pastDays,
      'past_hours': pastHours,
      'forecast_days': forecastDays,
      'forecast_hours': forecastHours,
      'start_date': nullIfEmpty(parsedLocations.startDate),
      'end_date': nullIfEmpty(parsedLocations.endDate),
      'start_hour': formatTime(startHour),
      'end_hour': formatTime(endHour),
      'timeformat': 'unixtime',
      'timezone': 'auto',
    };
  }
}
