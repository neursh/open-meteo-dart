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

  EnsembleApi({
    super.apiUrl = 'https://ensemble-api.open-meteo.com/v1/ensemble',
    super.apiKey,
    required this.models,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
  });

  EnsembleApi copyWith(
    String? apiUrl,
    String? apiKey,
    List<EnsembleModel>? models,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
  ) =>
      EnsembleApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        models: models ?? this.models,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<EnsembleHourly>? hourly,
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
    DateTime? startMinutely15,
    DateTime? endMinutely15,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
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
          startMinutely15: startMinutely15,
          endMinutely15: endMinutely15,
        ),
      );

  Future<ApiResponse<EnsembleApi>> request({
    required double latitude,
    required double longitude,
    List<EnsembleHourly>? hourly,
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
    DateTime? startMinutely15,
    DateTime? endMinutely15,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          hourly: hourly,
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
          startMinutely15: startMinutely15,
          endMinutely15: endMinutely15,
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
    required DateTime? startMinutely15,
    required DateTime? endMinutely15,
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
