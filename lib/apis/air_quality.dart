import '../enums/air_quality_domain.dart';
import '../enums/current.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../utils.dart';

/// Pollutants and pollen forecast in 11 km resolution.
///
/// https://open-meteo.com/en/docs/air-quality-api/
class AirQuality {
  /// Custom API URL, format: `https://<domain>/<version>/`
  String apiUrl;

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  final double latitude, longitude;

  /// Automatically combine both domains or specifically select
  /// the European `AirQualityDomains.cams_europe` or global domain `AirQualityDomains.cams_global`.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  AirQualityDomains? domains;

  /// If set, yesterday or the day before yesterday data are also returned.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  int? past_days;

  /// Per default, 5 days are returned. Up to 7 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  int? forecast_days;

  /// Similar to forecast_days, the number of timesteps of hourly data can controlled.
  /// Instead of using the current day as a reference, the current hour is used.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  int? forecast_hours, past_hours;

  /// The time interval to get weather data.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  DateTime? start_date, end_date;

  /// The time interval to get weather data for hourly data.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  DateTime? start_hour, end_hour;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  CellSelection? cell_selection;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/air-quality-api/
  String? apikey;

  AirQuality({
    this.apiUrl = 'https://air-quality-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.domains,
    this.past_days,
    this.forecast_days,
    this.forecast_hours,
    this.past_hours,
    this.start_date,
    this.end_date,
    this.start_hour,
    this.end_hour,
    this.cell_selection,
    this.apikey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> raw_request({
    List<Hourly>? hourly,
    List<Current>? current,
  }) =>
      sendHttpRequest(apiUrl, 'air-quality', {
        'domains': domains?.name,
        'past_days': past_days,
        'forecast_days': forecast_days,
        'forecast_hours': forecast_hours,
        'past_hours': past_hours,
        'start_date': formatDate(start_date),
        'end_date': formatDate(end_date),
        'start_hour': formatTime(start_hour),
        'end_hour': formatTime(end_hour),
        'call_selection': cell_selection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      });
}
