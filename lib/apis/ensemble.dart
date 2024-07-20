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
  final String? apiKey;

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final double latitude, longitude;

  /// If `TemperatureUnit.fahrenheit` is set, all temperature values are converted to Fahrenheit.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final TemperatureUnit? temperatureUnit;

  ///Other wind speed speed units: `WindspeedUnit.ms`, `WindspeedUnit.mph` and `WindspeedUnit.kn`.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final WindspeedUnit? windspeedUnit;

  /// Other precipitation amount units: `PrecipitationUnit.inch`
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final PrecipitationUnit? precipitationUnit;

  /// The elevation used for statistical downscaling. Per default,
  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final CellSelection? cellSelection;

  /// a 90 meter digital elevation model is used.
  /// You can manually set the elevation to correctly match mountain peaks.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final double? elevation;

  /// If `past_days` is set, past weather data can be returned.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? pastDays;

  /// Per default, only 7 days are returned. Up to 35 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? forecastDays;

  /// Similar to forecast_days, the number of timesteps of hourly and 15-minutely
  /// data can controlled. Instead of using the current day as a reference,
  /// the current hour or the current 15-minute time-step is used.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? forecastHours, forecastMinutely15;

  /// Similar to forecast_days, the number of timesteps of hourly and 15-minutely
  /// data can controlled. Instead of using the current day as a reference,
  /// the current hour or the current 15-minute time-step is used.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final int? pastHours, pastMinutely15;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final DateTime? startDate, endDate;

  /// The time interval to get weather data for hourly or 15 minutely data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final DateTime? startHour, endHour;

  /// The time interval to get weather data for hourly or 15 minutely data.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final DateTime? startMinutely15, endMinutely15;

  Ensemble({
    this.apiUrl = 'https://ensemble-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.pastDays,
    this.forecastDays,
    this.forecastHours,
    this.forecastMinutely15,
    this.pastHours,
    this.pastMinutely15,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
    this.startMinutely15,
    this.endMinutely15,
    this.cellSelection,
    this.apiKey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> requestJson({
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
        'temperature_unit': temperatureUnit?.name,
        'windspeed_unit': windspeedUnit?.name,
        'precipitation_unit': precipitationUnit?.name,
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'forecast_minutely_15': forecastMinutely15,
        'past_hours': pastHours,
        'past_minutely_15': pastMinutely15,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'start_minytely_15': formatTime(startMinutely15),
        'end_minutely_15': formatTime(endMinutely15),
        'cell_selection': cellSelection?.name,
        'apikey': apiKey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
