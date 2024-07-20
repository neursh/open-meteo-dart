import '../enums/daily.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Discover how weather has shaped our world from 1940 until now.
///
/// https://open-meteo.com/en/docs/historical-weather-api/
class Historical {
  String apiUrl;
  final double latitude, longitude;
  double? elevation;
  DateTime? start_date, end_date;
  TemperatureUnit? temperature_unit;
  WindspeedUnit? windspeed_unit;
  PrecipitationUnit? precipitation_unit;
  CellSelection? cell_selection;
  String? apikey;

  Historical({
    this.apiUrl = 'https://archive-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.start_date,
    this.end_date,
    this.temperature_unit,
    this.windspeed_unit,
    this.precipitation_unit,
    this.apikey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> raw_request({
    List<Hourly>? hourly,
    List<Daily>? daily,
  }) =>
      sendHttpRequest(apiUrl, 'archive', _queryParamMap(daily, hourly));

  Future<WeatherResponse> request({
    List<Hourly>? hourly,
    List<Daily>? daily,
  }) =>
      sendApiRequest(apiUrl, 'archive', _queryParamMap(daily, hourly))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(
    List<Daily>? daily,
    List<Hourly>? hourly,
  ) =>
      {
        'daily': daily?.map((option) => option.name).join(","),
        'hourly': hourly?.map((option) => option.name).join(","),
        'elevation': elevation,
        'start_date': formatDate(start_date),
        'end_date': formatDate(end_date),
        'temperature_unit': temperature_unit?.name,
        'windspeed_unit': windspeed_unit?.name,
        'precipitaion_unit': precipitation_unit?.name,
        'cell_selection': cell_selection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
