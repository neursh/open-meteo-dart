import '../api.dart';
import '../options.dart';
import '../response.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Pollutants and pollen forecast in 11 km resolution.
///
/// https://open-meteo.com/en/docs/air-quality-api/
class AirQualityApi extends BaseApi {
  final CellSelection? cellSelection;
  final AirQualityDomains? domains;

  final int? pastDays, pastHours;
  final int? forecastDays, forecastHours;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;

  AirQualityApi({
    super.apiUrl = 'https://air-quality-api.open-meteo.com/v1/air-quality',
    super.apiKey,
    this.cellSelection,
    this.domains,
    this.pastDays,
    this.pastHours,
    this.forecastDays,
    this.forecastHours,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
  });

  AirQualityApi copyWith({
    String? apiUrl,
    String? apiKey,
    CellSelection? cellSelection,
    AirQualityDomains? domains,
    int? pastDays,
    int? pastHours,
    int? forecastDays,
    int? forecastHours,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startHour,
    DateTime? endHour,
  }) =>
      AirQualityApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        cellSelection: cellSelection ?? this.cellSelection,
        domains: domains ?? this.domains,
        pastDays: pastDays ?? this.pastDays,
        pastHours: pastHours ?? this.pastHours,
        forecastDays: forecastDays ?? this.forecastDays,
        forecastHours: forecastHours ?? this.forecastHours,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startHour: startHour ?? this.startHour,
        endHour: endHour ?? this.endHour,
      );

  Future<Map<String, dynamic>> requestJson({
    required double latitude,
    required double longitude,
    List<AirQualityHourly>? hourly,
    List<AirQualityCurrent>? current,
  }) =>
      apiRequestJson(this, _queryParamMap(latitude, longitude, hourly, current));

  Future<ApiResponse<AirQualityApi>> request({
    required double latitude,
    required double longitude,
    List<AirQualityHourly>? hourly,
    List<AirQualityCurrent>? current,
  }) =>
      apiRequestFlatBuffer(
              this, _queryParamMap(latitude, longitude, hourly, current))
          .then((data) => ApiResponse.fromFlatBuffer(
                data,
                hourlyHashes: AirQualityHourly.hashes,
                currentHashes: AirQualityCurrent.hashes,
              ));

  Map<String, dynamic> _queryParamMap(
    double latitude,
    double longitude,
    List<AirQualityHourly>? hourly,
    List<AirQualityCurrent>? current,
  ) =>
      {
        'hourly': hourly?.map((option) => option.name).join(","),
        'current': current?.map((option) => option.name).join(","),
        'domains': domains?.name,
        'past_days': pastDays,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'past_hours': pastHours,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'call_selection': cellSelection?.name,
        'apikey': apiKey,
        'latitude': latitude,
        'longitude': longitude,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

enum AirQualityCurrent with WeatherParameter<AirQualityApi, Current> {
  european_aqi(Variable.european_aqi),
  us_aqi(Variable.us_aqi),
  pm10(Variable.pm10),
  pm2_5(Variable.pm2p5),
  carbon_monoxide(Variable.carbon_monoxide),
  nitrogen_dioxide(Variable.nitrogen_dioxide),
  sulphur_dioxide(Variable.sulphur_dioxide),
  ozone(Variable.ozone),
  aerosol_optical_depth(Variable.aerosol_optical_depth),
  dust(Variable.dust),
  uv_index(Variable.uv_index),
  uv_index_clear_sky(Variable.uv_index_clear_sky),
  ammonia(Variable.ammonia),
  alder_pollen(Variable.alder_pollen),
  birch_pollen(Variable.birch_pollen),
  grass_pollen(Variable.grass_pollen),
  mugwort_pollen(Variable.mugwort_pollen),
  olive_pollen(Variable.olive_pollen),
  ragweed_pollen(Variable.ragweed_pollen);

  @override
  final Variable variable;

  const AirQualityCurrent(this.variable);

  static final Map<int, AirQualityCurrent> hashes =
      makeHashes(AirQualityCurrent.values);
}

enum AirQualityHourly with WeatherParameter<AirQualityApi, Hourly> {
  pm10(Variable.pm10),
  pm2_5(Variable.pm2p5),
  carbon_monoxide(Variable.carbon_monoxide),
  nitrogen_dioxide(Variable.nitrogen_dioxide),
  sulphur_dioxide(Variable.sulphur_dioxide),
  ozone(Variable.ozone),
  aerosol_optical_depth(Variable.aerosol_optical_depth),
  dust(Variable.dust),
  uv_index(Variable.uv_index),
  uv_index_clear_sky(Variable.uv_index_clear_sky),
  ammonia(Variable.ammonia),
  alder_pollen(Variable.alder_pollen),
  birch_pollen(Variable.birch_pollen),
  grass_pollen(Variable.grass_pollen),
  mugwort_pollen(Variable.mugwort_pollen),
  olive_pollen(Variable.olive_pollen),
  ragweed_pollen(Variable.ragweed_pollen),
  european_aqi(Variable.european_aqi),
  european_aqi_pm2_5(Variable.european_aqi_pm2p5),
  european_aqi_pm10(Variable.european_aqi_pm10),
  european_aqi_nitrogen_dioxide(Variable.european_aqi_nitrogen_dioxide),
  european_aqi_ozone(Variable.european_aqi_ozone),
  european_aqi_sulphur_dioxide(Variable.european_aqi_sulphur_dioxide),
  us_aqi(Variable.us_aqi),
  us_aqi_pm2_5(Variable.us_aqi_pm2p5),
  us_aqi_pm10(Variable.us_aqi_pm10),
  us_aqi_nitrogen_dioxide(Variable.us_aqi_nitrogen_dioxide),
  us_aqi_carbon_monoxide(Variable.us_aqi_carbon_monoxide),
  us_aqi_ozone(Variable.us_aqi_ozone),
  us_aqi_sulphur_dioxide(Variable.us_aqi_sulphur_dioxide);

  @override
  final Variable variable;

  const AirQualityHourly(this.variable);

  static final Map<int, AirQualityHourly> hashes =
      makeHashes(AirQualityHourly.values);
}

enum AirQualityDomains { cams_europe, cams_global }
