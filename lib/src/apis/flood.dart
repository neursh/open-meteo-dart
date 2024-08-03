import '../enums/daily.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Simulated river discharge at 5 km resolution from 1984 up to 7 months forecast.
///
/// https://open-meteo.com/en/docs/flood-api/
class Flood {
  /// Custom API URL, format: `https://<domain>/<version>/`.
  final String apiUrl;

  /// Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final String? apikey;

  /// Geographical WGS84 coordinates of the location.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final double latitude, longitude;

  /// If `pastDays` is set, past weather data can be returned.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final int? pastDays;

  /// Per default, only 92 days are returned. Up to 210 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final int? forecastDays;

  /// The time interval to get data. Data are available from 1984-01-01 until 7 month forecast.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final DateTime? startDate, endDate;

  /// If `true`, all forecast ensemble members will be returned.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final bool? ensemble;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final CellSelection? cellSelection;

  Flood({
    this.apiUrl = 'https://flood-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.pastDays,
    this.forecastDays,
    this.startDate,
    this.endDate,
    this.cellSelection,
    this.apikey,
    this.ensemble,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> rawRequest({List<Daily>? daily}) =>
      sendHttpRequest(apiUrl, 'flood', _queryParamMap(daily));

  Future<WeatherResponse> request({List<Daily>? daily}) =>
      sendApiRequest(apiUrl, 'flood', _queryParamMap(daily))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(List<Daily>? daily) => {
        'daily': daily?.map((option) => option.name).join(","),
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'ensemble': ensemble,
        'cell_selection': cellSelection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
