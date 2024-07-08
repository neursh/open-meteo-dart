import '../enums/climate_model.dart';
import '../enums/daily.dart';
import '../enums/prefcls.dart';
import '../utils.dart';

/// Explore Climate Change on a Local Level with High-Resolution Climate Data
///
/// https://open-meteo.com/en/docs/climate-api/
class Climate {
  /// Custom API URL, format: `https://<domain>/<version>/`.
  String apiUrl;

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  final double latitude, longitude;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  DateTime start_date, end_date;

  /// If `TemperatureUnit.fahrenheit` is set, all temperature values are converted to Fahrenheit.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  TemperatureUnit? temperature_unit;

  /// Other wind speed speed units: `WindspeedUnit.ms`, `WindspeedUnit.mph` and `WindspeedUnit.kn`.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  WindspeedUnit? windspeed_unit;

  /// Other precipitation amount units: `PrecipitationUnit.inch`
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  PrecipitationUnit? precipitation_unit;

  /// Setting disable_bias_correction to true disables statistical downscaling
  /// and bias correction onto ERA5-Land. By default, all data is corrected
  /// using linear bias correction, and coefficients have been calculated for
  /// each month over a 50-year time series. The climate change signal is
  /// not affected by linear bias correction.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  bool? disable_bias_correction;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  CellSelection? cell_selection;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/climate-api/
  String? apikey;

  Climate({
    this.apiUrl = 'https://climate-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    required this.start_date,
    required this.end_date,
    this.temperature_unit,
    this.windspeed_unit,
    this.precipitation_unit,
    this.disable_bias_correction,
    this.cell_selection,
    this.apikey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> raw_request({
    required List<Daily> daily,
    required List<ClimateModel> models,
  }) =>
      sendHttpRequest(apiUrl, 'climate', {
        'start_date': formatDate(start_date),
        'end_date': formatDate(end_date),
        'temperature_unit': temperature_unit?.name,
        'windspeed_unit': windspeed_unit?.name,
        'precipitation_unit': precipitation_unit?.name,
        'disable_bias_correction': disable_bias_correction,
        'cell_selection': cell_selection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      });
}
