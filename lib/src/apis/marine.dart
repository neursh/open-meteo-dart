import '../api.dart';
import '../enums/prefcls.dart';
import '../response.dart';
import '../utils.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Hourly wave forecasts at 5 km resolution
///
/// https://open-meteo.com/en/docs/marine-weather-api/
class MarineApi extends BaseApi {
  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final LengthUnit? lengthUnit;
  final CellSelection? cellSelection;

  final int? pastDays, pastHours;
  final int? forecastDays, forecastHours;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;

  MarineApi({
    super.apiUrl = 'https://marine-api.open-meteo.com/v1/marine',
    super.apiKey,
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
  });

  Future<Map<String, dynamic>> rawRequest({
    required double latitude,
    required double longitude,
    List<CurrentMarine>? current,
    List<HourlyMarine>? hourly,
    List<DailyMarine>? daily,
  }) =>
      requestJson(
          this, _queryParamMap(latitude, longitude, current, hourly, daily));

  Future<Response<MarineApi>> request({
    required double latitude,
    required double longitude,
    List<CurrentMarine>? current,
    List<HourlyMarine>? hourly,
    List<DailyMarine>? daily,
  }) =>
      requestFlatBuffer(
              this, _queryParamMap(latitude, longitude, current, hourly, daily))
          .then((data) => Response.fromFlatBuffer(
                data,
                currentHashes: CurrentMarine.hashes,
                hourlyHashes: HourlyMarine.hashes,
                dailyHashes: DailyMarine.hashes,
              ));

  Map<String, dynamic> _queryParamMap(
    double latitude,
    double longitude,
    List<CurrentMarine>? current,
    List<HourlyMarine>? hourly,
    List<DailyMarine>? daily,
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
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

enum CurrentMarine with WeatherParameter<MarineApi, Current> {
  wave_height(Variable.wave_height),
  wave_direction(Variable.wave_direction),
  wave_period(Variable.wave_period),
  wind_wave_height(Variable.wind_wave_height),
  wind_wave_direction(Variable.wind_wave_direction),
  wind_wave_period(Variable.wind_wave_period),
  wind_wave_peak_period(Variable.wind_wave_peak_period),
  swell_wave_height(Variable.swell_wave_height),
  swell_wave_direction(Variable.swell_wave_direction),
  swell_wave_period(Variable.swell_wave_period),
  swell_wave_peak_period(Variable.swell_wave_peak_period),
  ocean_current_velocity(Variable.ocean_current_velocity),
  ocean_current_direction(Variable.ocean_current_direction);

  @override
  final Variable variable;

  const CurrentMarine(this.variable);

  static final Map<int, CurrentMarine> hashes =
      makeHashes(CurrentMarine.values);
}

enum HourlyMarine with WeatherParameter<MarineApi, Hourly> {
  wave_height(Variable.wave_height),
  wave_direction(Variable.wave_direction),
  wave_period(Variable.wave_period),
  wind_wave_height(Variable.wind_wave_height),
  wind_wave_direction(Variable.wind_wave_direction),
  wind_wave_period(Variable.wind_wave_period),
  wind_wave_peak_period(Variable.wind_wave_peak_period),
  swell_wave_height(Variable.swell_wave_height),
  swell_wave_direction(Variable.swell_wave_direction),
  swell_wave_period(Variable.swell_wave_period),
  swell_wave_peak_period(Variable.swell_wave_peak_period),
  ocean_current_velocity(Variable.ocean_current_velocity),
  ocean_current_direction(Variable.ocean_current_direction);

  @override
  final Variable variable;

  const HourlyMarine(this.variable);

  static final Map<int, HourlyMarine> hashes = makeHashes(HourlyMarine.values);
}

enum DailyMarine with WeatherParameter<MarineApi, Daily> {
  wave_height_max(Variable.wave_height, aggregation: Aggregation.maximum),
  wave_direction_dominant(Variable.wave_direction,
      aggregation: Aggregation.dominant),
  wave_period_max(Variable.wave_period, aggregation: Aggregation.maximum),
  wind_wave_height_max(Variable.wind_wave_height,
      aggregation: Aggregation.maximum),
  wind_wave_direction_dominant(Variable.wind_wave_direction,
      aggregation: Aggregation.dominant),
  wind_wave_period_max(Variable.wind_wave_period,
      aggregation: Aggregation.maximum),
  wind_wave_peak_period_max(Variable.wind_wave_peak_period,
      aggregation: Aggregation.maximum),
  swell_wave_height_max(Variable.swell_wave_height,
      aggregation: Aggregation.maximum),
  swell_wave_direction_dominant(Variable.swell_wave_direction,
      aggregation: Aggregation.dominant),
  swell_wave_period_max(Variable.swell_wave_period,
      aggregation: Aggregation.maximum),
  swell_wave_peak_period_max(Variable.swell_wave_peak_period,
      aggregation: Aggregation.maximum);

  @override
  final Variable variable;

  @override
  final Aggregation aggregation;

  const DailyMarine(
    this.variable, {
    this.aggregation = Aggregation.none,
  });

  static final Map<int, DailyMarine> hashes = makeHashes(DailyMarine.values);
}

void main() async {
  final api = MarineApi();
  final response = await api.request(
    latitude: 54.544587,
    longitude: 10.227487,
    daily: DailyMarine.values,
  );
  print('${DailyMarine.values.length} == ${response.dailyData.keys.length}');
  print(DailyMarine.values.where((v) => !response.dailyData.keys.contains(v)));
  print(DailyMarine.hashes);
  print(DailyMarine.hashes.length);
}
