import '../enums/climate_model.dart';
import '../enums/daily.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Explore Climate Change on a Local Level with High-Resolution Climate Data
///
/// https://open-meteo.com/en/docs/climate-api/
class Climate {
  /// Custom API URL, format: `https://<domain>/<version>/`.
  final String apiUrl;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final String? apiKey;

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final double latitude, longitude;

  /// If `TemperatureUnit.fahrenheit` is set, all temperature values are converted to Fahrenheit.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final TemperatureUnit? temperatureUnit;

  /// Other wind speed speed units: `WindspeedUnit.ms`, `WindspeedUnit.mph` and `WindspeedUnit.kn`.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final WindspeedUnit? windspeedUnit;

  /// Other precipitation amount units: `PrecipitationUnit.inch`
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final PrecipitationUnit? precipitationUnit;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final CellSelection? cellSelection;

  /// Setting disable_bias_correction to true disables statistical downscaling
  /// and bias correction onto ERA5-Land. By default, all data is corrected
  /// using linear bias correction, and coefficients have been calculated for
  /// each month over a 50-year time series. The climate change signal is
  /// not affected by linear bias correction.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final bool? disableBiasCorrection;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final DateTime startDate, endDate;

  Climate({
    this.apiUrl = 'https://climate-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.disableBiasCorrection,
    this.cellSelection,
    this.apiKey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> rawRequest({
    required List<Daily> daily,
    required List<ClimateModel> models,
  }) =>
      sendHttpRequest(apiUrl, 'climate', _queryParamMap(daily, models));

  Future<WeatherResponse> request({
    required List<Daily> daily,
    required List<ClimateModel> models,
  }) =>
      sendApiRequest(apiUrl, 'climate', _queryParamMap(daily, models))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(
    List<Daily> daily,
    List<ClimateModel> models,
  ) =>
      {
        'daily': daily.map((value) => value.name).toList().join(','),
        'models': models.map((value) => value.name).toList().join(','),
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'temperature_unit': temperatureUnit?.name,
        'windspeed_unit': windspeedUnit?.name,
        'precipitation_unit': precipitationUnit?.name,
        'disable_bias_correction': disableBiasCorrection,
        'cell_selection': cellSelection?.name,
        'apikey': apiKey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
