import '../api.dart';
import '../enums/ensemble.dart';
import '../options.dart';
import '../response.dart';

/// Hundreds Of Weather Forecasts, Every time, Everywhere, All at Once.
///
/// https://open-meteo.com/en/docs/ensemble-api/
class EnsembleApi extends BaseApi {
  final List<EnsembleModel> models;

  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;

  final int? pastDays, pastHours, pastMinutely15;
  final int? forecastDays, forecastHours, forecastMinutely15;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;
  final DateTime? startMinutely15, endMinutely15;

  EnsembleApi({
    super.apiUrl = 'https://ensemble-api.open-meteo.com/v1/ensemble',
    super.apiKey,
    required this.models,
    this.elevation,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
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
    this.startMinutely15,
    this.endMinutely15,
  });

  EnsembleApi copyWith(
    String? apiUrl,
    String? apiKey,
    List<EnsembleModel>? models,
    double? elevation,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
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
    DateTime? startMinutely15,
    DateTime? endMinutely15,
  ) =>
      EnsembleApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        models: models ?? this.models,
        elevation: elevation ?? this.elevation,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
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
        startMinutely15: startMinutely15 ?? this.startMinutely15,
        endMinutely15: endMinutely15 ?? this.endMinutely15,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<EnsembleHourly>? hourly,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
        ),
      );

  Future<ApiResponse<EnsembleApi>> request({
    required double latitude,
    required double longitude,
    List<EnsembleHourly>? hourly,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data,
          hourlyHashes: EnsembleHourly.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required double latitude,
    required double longitude,
    required List<EnsembleHourly>? hourly,
  }) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'models': models.map((value) => value.name),
        'hourly': hourly?.map((value) => value.name),
        'temperature_unit': temperatureUnit?.name,
        'windspeed_unit': windspeedUnit?.name,
        'precipitation_unit': precipitationUnit?.name,
        'cell_selection': cellSelection?.name,
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
        'start_minytely_15': formatTime(startMinutely15),
        'end_minutely_15': formatTime(endMinutely15),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
