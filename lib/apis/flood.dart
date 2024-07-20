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

  /// If `past_days` is set, past weather data can be returned.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final int? past_days;

  /// Per default, only 92 days are returned. Up to 210 days of forecast are possible.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final int? forecast_days;

  /// The time interval to get data. Data are available from 1984-01-01 until 7 month forecast.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final DateTime? start_date, end_date;

  /// If `true`, all forecast ensemble members will be returned.
  ///
  /// https://open-meteo.com/en/docs/flood-api/
  final bool? ensemble;

  /// Set a preference how grid-cells are selected.
  ///
  /// https://open-meteo.com/en/docs/ensemble-api/
  final CellSelection? cell_selection;

  Flood({
    this.apiUrl = 'https://flood-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.past_days,
    this.forecast_days,
    this.start_date,
    this.end_date,
    this.cell_selection,
    this.apikey,
    this.ensemble,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> raw_request({List<Daily>? daily}) =>
      sendHttpRequest(apiUrl, 'flood', _queryParamMap(daily));

  Future<WeatherResponse> request({List<Daily>? daily}) =>
      sendApiRequest(apiUrl, 'flood', _queryParamMap(daily))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(List<Daily>? daily) => {
        'daily': daily?.map((option) => option.name).join(","),
        'past_days': past_days,
        'forecast_days': forecast_days,
        'start_date': formatDate(start_date),
        'end_date': formatDate(end_date),
        'ensemble': ensemble,
        'cell_selection': cell_selection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
