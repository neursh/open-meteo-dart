import '../api.dart';
import '../enums/climate.dart';
import '../options.dart';
import '../response.dart';
import '../model_export.dart';

/// Explore Climate Change on a Local Level with High-Resolution Climate Data
///
/// https://open-meteo.com/en/docs/climate-api/
class ClimateApi extends BaseApi {
  final Set<OpenMeteoModel> models;
  final TemperatureUnit temperatureUnit;
  final WindspeedUnit windspeedUnit;
  final PrecipitationUnit precipitationUnit;
  final CellSelection cellSelection;
  final bool disableBiasCorrection;

  const ClimateApi({
    super.apiUrl = 'https://climate-api.open-meteo.com/v1/climate',
    super.apiKey,
    super.userAgent,
    required this.models,
    this.temperatureUnit = TemperatureUnit.celsius,
    this.windspeedUnit = WindspeedUnit.kmh,
    this.precipitationUnit = PrecipitationUnit.mm,
    this.cellSelection = CellSelection.land,
    this.disableBiasCorrection = false,
  });

  ClimateApi copyWith({
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    Set<OpenMeteoModel>? models,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    bool? disableBiasCorrection,
  }) =>
      ClimateApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        models: models ?? this.models,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
        disableBiasCorrection:
            disableBiasCorrection ?? this.disableBiasCorrection,
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
    required Set<ClimateDaily> daily,
  }) =>
      apiRequestJson(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          startDate: startDate,
          endDate: endDate,
          daily: daily,
        ),
      );

  /// This method returns a Dart object,
  /// and throws an exception if the API returns an error response,
  /// recommended for most use cases.
  Future<ApiResponse<ClimateApi>> request({
    required Set<double> latitude,
    required Set<double> longitude,
    required DateTime startDate,
    required DateTime endDate,
    required Set<ClimateDaily> daily,
  }) =>
      apiRequestFlatBuffer(
        this,
        _queryParamMap(
          latitude: latitude,
          longitude: longitude,
          startDate: startDate,
          endDate: endDate,
          daily: daily,
        ),
      ).then(
        (data) => ApiResponse.fromFlatBuffer(
          data.$1,
          data.$2,
          dailyHashes: ClimateDaily.hashes,
        ),
      );

  Map<String, dynamic> _queryParamMap({
    required Set<double> latitude,
    required Set<double> longitude,
    required DateTime startDate,
    required DateTime endDate,
    required Set<ClimateDaily> daily,
  }) =>
      {
        'models': models,
        'latitude': latitude,
        'longitude': longitude,
        'daily': daily,
        'temperature_unit':
            nullIfEqual(temperatureUnit, TemperatureUnit.celsius),
        'windspeed_unit': nullIfEqual(windspeedUnit, WindspeedUnit.kmh),
        'precipitation_unit':
            nullIfEqual(precipitationUnit, PrecipitationUnit.mm),
        'cell_selection': nullIfEqual(cellSelection, CellSelection.land),
        'disable_bias_correction': nullIfEqual(disableBiasCorrection, false),
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
