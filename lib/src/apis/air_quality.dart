import '../enums/air_quality_domain.dart';
import '../enums/current.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Pollutants and pollen forecast in 11 km resolution.
///
/// https://open-meteo.com/en/docs/air-quality-api/
class AirQuality {
  /// Custom API URL, format: `https://<domain>/<version>/`
  final String apiUrl;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final String? apiKey;

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final double latitude, longitude;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final CellSelection? cellSelection;

  /// Automatically combine both domains or specifically select
  /// the European `AirQualityDomains.cams_europe` or global domain `AirQualityDomains.cams_global`.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final AirQualityDomains? domains;

  /// If set, yesterday or the day before yesterday data are also returned.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final int? pastDays;

  /// Per default, 5 days are returned. Up to 7 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final int? forecastDays;

  /// Similar to forecast_days, the number of timesteps of hourly data can controlled.
  /// Instead of using the current day as a reference, the current hour is used.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final int? forecastHours, pastHours;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final DateTime? startDate, endDate;

  /// The time interval to get weather data for hourly data.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final DateTime? startHour, endHour;

  AirQuality({
    this.apiUrl = 'https://air-quality-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.domains,
    this.pastDays,
    this.forecastDays,
    this.forecastHours,
    this.pastHours,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
    this.cellSelection,
    this.apiKey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> rawRequest({
    List<Hourly>? hourly,
    List<Current>? current,
  }) =>
      sendHttpRequest(apiUrl, 'air-quality', _queryParamMap(hourly, current));

  Future<WeatherResponse> request({
    List<Hourly>? hourly,
    List<Current>? current,
  }) =>
      sendApiRequest(apiUrl, 'air-quality', _queryParamMap(hourly, current))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(
    List<Hourly>? hourly,
    List<Current>? current,
  ) =>
      {
        'hourly': hourly?.map((option) => option.name).join(","),
        'current': current?.map((option) => option.name).join(","),
        'domains': domains?.name,
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'past_hours': pastHours,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'call_selection': cellSelection?.name,
        'apikey': apiKey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
