import '../api.dart';
import '../enums/ensemble.dart';
import '../options.dart';
import '../response.dart';
import '../model_export.dart';

/// Hundreds Of Weather Forecasts, Every time, Everywhere, All at Once.
///
/// https://open-meteo.com/en/docs/ensemble-api/
class EnsembleApi extends BaseApi {
  final Set<OpenMeteoModel> models;
  final TemperatureUnit temperatureUnit;
  final WindspeedUnit windspeedUnit;
  final PrecipitationUnit precipitationUnit;
  final CellSelection cellSelection;

  const EnsembleApi({
    super.apiUrl = 'https://ensemble-api.open-meteo.com/v1/ensemble',
    super.apiKey,
    super.userAgent,
    required this.models,
    this.temperatureUnit = TemperatureUnit.celsius,
    this.windspeedUnit = WindspeedUnit.kmh,
    this.precipitationUnit = PrecipitationUnit.mm,
    this.cellSelection = CellSelection.land,
  });

  EnsembleApi copyWith(
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    Set<OpenMeteoModel>? models,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
  ) =>
      EnsembleApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        models: models ?? this.models,
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
    required Set<Location> locations,
    required Set<EnsembleHourly> hourly,
    int? pastDays,
    int? pastHours,
    int? pastMinutely15,
    int? forecastDays,
    int? forecastHours,
    int? forecastMinutely15,
    DateTime? startHour,
    DateTime? endHour,
    DateTime? startMinutely15,
    DateTime? endMinutely15,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          locations: locations,
          hourly: hourly,
          pastDays: pastDays,
          pastHours: pastHours,
          pastMinutely15: pastMinutely15,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          forecastMinutely15: forecastMinutely15,
          startHour: startHour,
          endHour: endHour,
          startMinutely15: startMinutely15,
          endMinutely15: endMinutely15,
        ),
      );

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
  Future<ApiResponse<EnsembleApi>> request({
    required Set<Location> locations,
    required Set<EnsembleHourly> hourly,
    int? pastDays,
    int? pastHours,
    int? pastMinutely15,
    int? forecastDays,
    int? forecastHours,
    int? forecastMinutely15,
    DateTime? startHour,
    DateTime? endHour,
    DateTime? startMinutely15,
    DateTime? endMinutely15,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          locations: locations,
          hourly: hourly,
          pastDays: pastDays,
          pastHours: pastHours,
          pastMinutely15: pastMinutely15,
          forecastDays: forecastDays,
          forecastHours: forecastHours,
          forecastMinutely15: forecastMinutely15,
          startHour: startHour,
          endHour: endHour,
          startMinutely15: startMinutely15,
          endMinutely15: endMinutely15,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data.$1,
          data.$2,
          hourlyHashes: EnsembleHourly.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required Set<Location> locations,
    required Set<EnsembleHourly> hourly,
    required int? pastDays,
    required int? pastHours,
    required int? pastMinutely15,
    required int? forecastDays,
    required int? forecastHours,
    required int? forecastMinutely15,
    required DateTime? startHour,
    required DateTime? endHour,
    required DateTime? startMinutely15,
    required DateTime? endMinutely15,
  }) {
    final parsedLocations = parseLocations(locations);
    return {
      'latitude': parsedLocations.latitude,
      'longitude': parsedLocations.longitude,
      'elevation': nullIfEmpty(parsedLocations.elevation),
      'models': models,
      'hourly': hourly,
      'temperature_unit': nullIfEqual(temperatureUnit, TemperatureUnit.celsius),
      'windspeed_unit': nullIfEqual(windspeedUnit, WindspeedUnit.kmh),
      'precipitation_unit':
          nullIfEqual(precipitationUnit, PrecipitationUnit.mm),
      'cell_selection': nullIfEqual(cellSelection, CellSelection.land),
      'past_days': pastDays,
      'past_hours': pastHours,
      'past_minutely_15': pastMinutely15,
      'forecast_days': forecastDays,
      'forecast_hours': forecastHours,
      'forecast_minutely_15': forecastMinutely15,
      'start_date': nullIfEmpty(parsedLocations.startDate),
      'end_date': nullIfEmpty(parsedLocations.endDate),
      'start_hour': formatTime(startHour),
      'end_hour': formatTime(endHour),
      'start_minytely_15': formatTime(startMinutely15),
      'end_minutely_15': formatTime(endMinutely15),
      'timeformat': 'unixtime',
      'timezone': 'auto',
    };
  }
}
