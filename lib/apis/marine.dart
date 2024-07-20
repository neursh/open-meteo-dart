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

  final TemperatureUnit? temperature_unit;
  final WindspeedUnit? windspeed_unit;
  final PrecipitationUnit? precipitation_unit;
  final LengthUnit? length_unit;
  final CellSelection? cell_selection;

  final int? past_days;
  final int? forecast_days, forecast_hours, past_hours;

  final DateTime? start_date, end_date;
  final DateTime? start_hour, end_hour;

  Marine({
    this.apiUrl = 'https://marine-api.open-meteo.com/v1/',
    required this.latitude,
    required this.longitude,
    this.temperature_unit,
    this.windspeed_unit,
    this.precipitation_unit,
    this.past_days,
    this.forecast_days,
    this.forecast_hours,
    this.past_hours,
    this.start_date,
    this.end_date,
    this.start_hour,
    this.end_hour,
    this.length_unit,
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
        'temperature_unit': temperature_unit?.name,
        'windspeed_unit': windspeed_unit?.name,
        'precipitation_unit': precipitation_unit?.name,
        'past_days': past_days,
        'forecast_days': forecast_days,
        'past_hours': past_hours,
        'start_date': formatDate(start_date),
        'end_date': formatDate(end_date),
        'start_hour': formatTime(start_hour),
        'end_hour': formatTime(end_hour),
        'length_unit': length_unit?.name,
        'cell_selection': cell_selection?.name,
        'apikey': apikey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}
