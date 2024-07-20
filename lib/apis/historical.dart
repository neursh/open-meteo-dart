import '../enums/daily.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Discover how weather has shaped our world from 1940 until now.
///
/// https://open-meteo.com/en/docs/historical-weather-api/
class Historical {
  final String apiUrl;
  final String? apikey;

  final double latitude, longitude;

  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;

  final DateTime? startDate, endDate;

  Historical({
    this.apiUrl = 'https://archive-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.startDate,
    this.endDate,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.apikey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> rawRequest({
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
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'temperature_unit': temperatureUnit?.name,
        'windspeed_unit': windspeedUnit?.name,
        'precipitaion_unit': precipitationUnit?.name,
        'cell_selection': cellSelection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
