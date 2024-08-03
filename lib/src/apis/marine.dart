import '../enums/current.dart';
import '../enums/daily.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Hourly wave forecasts at 5 km resolution
///
/// https://open-meteo.com/en/docs/marine-weather-api/
class Marine {
  final String apiUrl;
  final String? apikey;

  final double latitude, longitude;

  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final LengthUnit? lengthUnit;
  final CellSelection? cellSelection;

  final int? pastDays;
  final int? forecastDays, forecastHours, pastHours;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;

  Marine({
    this.apiUrl = 'https://marine-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.pastDays,
    this.forecastDays,
    this.forecastHours,
    this.pastHours,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
    this.lengthUnit,
    this.cellSelection,
    this.apikey,
  }) {
    Uri.parse(apiUrl);

    throwCheckLatLng(latitude, longitude);
  }

  Future<Map<String, dynamic>> rawRequest({
    List<Hourly>? hourly,
    List<Daily>? daily,
    List<Current>? current,
  }) =>
      sendHttpRequest(apiUrl, 'marine', _queryParamMap(hourly, daily, current));

  Future<WeatherResponse> request({
    List<Hourly>? hourly,
    List<Daily>? daily,
    List<Current>? current,
  }) =>
      sendApiRequest(apiUrl, 'marine', _queryParamMap(hourly, daily, current))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(
    List<Hourly>? hourly,
    List<Daily>? daily,
    List<Current>? current,
  ) =>
      {
        'daily': daily?.map((option) => option.name).join(","),
        'hourly': hourly?.map((option) => option.name).join(","),
        'current': current?.map((option) => option.name).join(","),
        'temperature_unit': temperatureUnit?.name,
        'windspeed_unit': windspeedUnit?.name,
        'precipitation_unit': precipitationUnit?.name,
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'past_hours': pastHours,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'length_unit': lengthUnit?.name,
        'cell_selection': cellSelection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
