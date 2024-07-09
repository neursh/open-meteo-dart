import '../enums/current.dart';
import '../enums/daily.dart';
import '../enums/hourly.dart';
import '../enums/prefcls.dart';
import '../utils.dart';

/// Seamless integration of high-resolution weather models with up 16 days forecast.
///
/// https://open-meteo.com/en/docs/
class Weather {
  String apiUrl;
  final double latitude, longitude;
  double? elevation;
  TemperatureUnit? temperature_unit;
  WindspeedUnit? windspeed_unit;
  PrecipitationUnit? precipitation_unit;
  int? past_days;
  int? forecast_days, forecast_hours, forecast_minutely_15;
  int? past_hours, past_minutely_15;
  DateTime? start_date, end_date;
  DateTime? start_hour, end_hour;
  DateTime? start_minutely_15, end_minutely_15;
  CellSelection? cell_selection;
  String? apikey;

  Weather({
    this.apiUrl = 'https://api.open-meteo.com/v1/',
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

  Future<Map<String, dynamic>> raw_request({
    List<Hourly>? hourly,
    List<Daily>? daily,
    List<Current>? current,
  }) =>
      sendHttpRequest(apiUrl, 'forecast', {
        'hourly': hourly?.join(','),
        'daily': daily?.join(','),
        'current': current?.join(','),
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
        'start_minutely_15': formatTime(start_minutely_15),
        'end_minutely_15': formatTime(end_minutely_15),
        'cell_selection': cell_selection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      });
}
