import '../enums/ensemble_model.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Hundreds Of Weather Forecasts, Every time, Everywhere, All at Once.
///
/// https://open-meteo.com/en/docs/ensemble-api/
class Ensemble {
  /// Custom API URL, format: `https://<domain>/<version>/`.
  final String apiUrl;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final String? apikey;

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final double latitude, longitude;

  /// If `TemperatureUnit.fahrenheit` is set, all temperature values are converted to Fahrenheit.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final TemperatureUnit? temperature_unit;

  ///Other wind speed speed units: `WindspeedUnit.ms`, `WindspeedUnit.mph` and `WindspeedUnit.kn`.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final WindspeedUnit? windspeed_unit;

  /// Other precipitation amount units: `PrecipitationUnit.inch`
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final PrecipitationUnit? precipitation_unit;

  /// The elevation used for statistical downscaling. Per default,
  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final CellSelection? cell_selection;

  /// a 90 meter digital elevation model is used.
  /// You can manually set the elevation to correctly match mountain peaks.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final double? elevation;

  /// If `past_days` is set, past weather data can be returned.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? past_days;

  /// Per default, only 7 days are returned. Up to 35 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? forecast_days;

  /// Similar to forecast_days, the number of timesteps of hourly and 15-minutely
  /// data can controlled. Instead of using the current day as a reference,
  /// the current hour or the current 15-minute time-step is used.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? forecast_hours, forecast_minutely_15;

  /// Similar to forecast_days, the number of timesteps of hourly and 15-minutely
  /// data can controlled. Instead of using the current day as a reference,
  /// the current hour or the current 15-minute time-step is used.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? past_hours, past_minutely_15;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final DateTime? start_date, end_date;

  /// The time interval to get weather data for hourly or 15 minutely data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final DateTime? start_hour, end_hour;

  /// The time interval to get weather data for hourly or 15 minutely data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final DateTime? start_minutely_15, end_minutely_15;

  Ensemble({
    this.apiUrl = 'https://ensemble-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.temperature_unit,
    this.windspeed_unit,
    this.precipitation_unit,
    this.past_days,
    this.forecast_days,
    this.forecast_hours,
    this.forecast_minutely_15,
    this.past_hours,
    this.past_minutely_15,
    this.start_date,
    this.end_date,
    this.start_hour,
    this.end_hour,
    this.start_minutely_15,
    this.end_minutely_15,
    this.cell_selection,
    this.apikey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> raw_request({
    required List<EnsembleModel> models,
    List<Hourly>? hourly,
  }) =>
      sendHttpRequest(apiUrl, 'ensemble', _queryParamMap(models, hourly));

  Future<WeatherResponse> request({
    required List<EnsembleModel> models,
    List<Hourly>? hourly,
  }) =>
      sendApiRequest(apiUrl, 'ensemble', _queryParamMap(models, hourly))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(
    List<EnsembleModel> models,
    List<Hourly>? hourly,
  ) =>
      {
        'models': models.map((value) => value.name).toList().join(','),
        'hourly': hourly?.map((value) => value.name).toList().join(','),
        'elevation': elevation,
        'temperature_unit': temperature_unit?.name,
        'windspeed_unit': windspeed_unit?.name,
        'precipitation_unit': precipitation_unit?.name,
        'past_days': past_days,
        'forecast_days': forecast_days,
        'forecast_hours': forecast_hours,
        'forecast_minutely_15': forecast_minutely_15,
        'past_hours': past_hours,
        'past_minutely_15': past_minutely_15,
        'start_date': formatDate(start_date),
        'end_date': formatDate(end_date),
        'start_hour': formatTime(start_hour),
        'end_hour': formatTime(end_hour),
        'start_minytely_15': formatTime(start_minutely_15),
        'end_minutely_15': formatTime(end_minutely_15),
        'cell_selection': cell_selection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
