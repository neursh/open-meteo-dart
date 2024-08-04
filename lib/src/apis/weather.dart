import '../api.dart';
import '../enums/prefcls.dart';
import '../response.dart';
import '../utils.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Seamless integration of high-resolution weather models with up 16 days forecast.
///
/// https://open-meteo.com/en/docs/
class WeatherApi extends BaseApi {
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

  WeatherApi({
    super.apiUrl = 'https://api.open-meteo.com/v1/forecast',
    super.apiKey,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.elevation,
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
  }) {
    Uri.parse(apiUrl);
  }

  Future<Map<String, dynamic>> rawRequest({
    required double latitude,
    required double longitude,
    List<HourlyWeather>? hourly,
    List<DailyWeather>? daily,
    List<CurrentWeather>? current,
  }) =>
      requestJson(
          this, _queryParamMap(latitude, longitude, hourly, daily, current));

  Future<Response<WeatherApi>> request({
    required double latitude,
    required double longitude,
    List<HourlyWeather>? hourly,
    List<DailyWeather>? daily,
    List<CurrentWeather>? current,
  }) =>
      requestFlatBuffer(
              this, _queryParamMap(latitude, longitude, hourly, daily, current))
          .then((data) => Response.fromFlatBuffer(
                data,
                currentHashes: CurrentWeather.hashes,
                hourlyHashes: HourlyWeather.hashes,
                dailyHashes: DailyWeather.hashes,
              ));

  Map<String, dynamic> _queryParamMap(
    double latitude,
    double longitude,
    List<HourlyWeather>? hourly,
    List<DailyWeather>? daily,
    List<CurrentWeather>? current,
  ) =>
      {
        'hourly': hourly?.map((option) => option.name),
        'daily': daily?.map((option) => option.name),
        'current': current?.map((option) => option.name),
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
        'cell_selection': cellSelection?.name,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

// typedef WeatherResponse = Response<WeatherApi>;

enum CurrentWeather with WeatherParameter<WeatherApi, Current> {
  temperature_2m(Variable.temperature, altitude: 2);

  @override
  final Variable variable;

  @override
  final int altitude;

  const CurrentWeather(this.variable, {this.altitude = 0});

  static final Map<int, CurrentWeather> hashes =
      makeHashes(CurrentWeather.values);
}

enum HourlyWeather with WeatherParameter<WeatherApi, Hourly> {
  x(Variable.aerosol_optical_depth);

  @override
  final Variable variable;

  const HourlyWeather(this.variable);

  static final Map<int, HourlyWeather> hashes =
      makeHashes(HourlyWeather.values);
}

enum DailyWeather with WeatherParameter<WeatherApi, Daily> {
  x(Variable.aerosol_optical_depth);

  @override
  final Variable variable;

  const DailyWeather(this.variable);

  static final Map<int, DailyWeather> hashes = makeHashes(DailyWeather.values);
}
