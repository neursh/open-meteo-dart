import '../enums/current.dart';
import '../enums/daily.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../models/weather.dart';
import '../utils.dart';

/// Seamless integration of high-resolution weather models with up 16 days forecast.
///
/// https://open-meteo.com/en/docs/
class Weather {
  final String apiUrl;
  final String? apikey;

  final double latitude, longitude;

  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;
  final int? pastDays;
  final int? forecastDays, forecastHours, forecastMinutely15;
  final int? pastHours, pastMinutely15;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;
  final DateTime? startMinutely15, endMinutely15;

  Weather({
    this.apiUrl = 'https://api.open-meteo.com/v1/',
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
      sendHttpRequest(
        apiUrl,
        'forecast',
        _queryParamMap(hourly, daily, current),
      );

  Future<WeatherResponse> request({
    List<Hourly>? hourly,
    List<Daily>? daily,
    List<Current>? current,
  }) =>
      sendApiRequest(apiUrl, 'forecast', _queryParamMap(hourly, daily, current))
          .then(WeatherResponse.fromFlatBuffer);

  Map<String, dynamic> _queryParamMap(
    List<Hourly>? hourly,
    List<Daily>? daily,
    List<Current>? current,
  ) =>
      {
        'hourly': hourly?.map((option) => option.name).join(","),
        'daily': daily?.map((option) => option.name).join(","),
        'current': current?.map((option) => option.name).join(","),
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
        'start_minutely_15': formatTime(startMinutely15),
        'end_minutely_15': formatTime(endMinutely15),
        'cell_selection': cellSelection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
