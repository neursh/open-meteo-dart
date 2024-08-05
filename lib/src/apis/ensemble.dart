import '../api.dart';
import '../options.dart';
import '../response.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Hundreds Of Weather Forecasts, Every time, Everywhere, All at Once.
///
/// https://open-meteo.com/en/docs/ensemble-api/
class EnsembleApi extends BaseApi {
  final List<EnsembleModel> models;

  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final double? elevation;

  final int? pastDays, pastHours, pastMinutely15;
  final int? forecastDays, forecastHours, forecastMinutely15;

  final DateTime? startDate, endDate;
  final DateTime? startHour, endHour;
  final DateTime? startMinutely15, endMinutely15;

  EnsembleApi({
    super.apiUrl = 'https://ensemble-api.open-meteo.com/v1/ensemble',
    super.apiKey,
    required this.models,
    this.elevation,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.pastDays,
    this.pastHours,
    this.pastMinutely15,
    this.forecastDays,
    this.forecastHours,
    this.forecastMinutely15,
    this.startDate,
    this.endDate,
    this.startHour,
    this.endHour,
    this.startMinutely15,
    this.endMinutely15,
  });

  EnsembleApi copyWith(
    String? apiUrl,
    String? apiKey,
    List<EnsembleModel>? models,
    double? elevation,
    TemperatureUnit? temperatureUnit,
    WindspeedUnit? windspeedUnit,
    PrecipitationUnit? precipitationUnit,
    CellSelection? cellSelection,
    int? pastDays,
    int? pastHours,
    int? pastMinutely15,
    int? forecastDays,
    int? forecastHours,
    int? forecastMinutely15,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startHour,
    DateTime? endHour,
    DateTime? startMinutely15,
    DateTime? endMinutely15,
  ) =>
      EnsembleApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        models: models ?? this.models,
        elevation: elevation ?? this.elevation,
        temperatureUnit: temperatureUnit ?? this.temperatureUnit,
        windspeedUnit: windspeedUnit ?? this.windspeedUnit,
        precipitationUnit: precipitationUnit ?? this.precipitationUnit,
        cellSelection: cellSelection ?? this.cellSelection,
        pastDays: pastDays ?? this.pastDays,
        pastHours: pastHours ?? this.pastHours,
        pastMinutely15: pastMinutely15 ?? this.pastMinutely15,
        forecastDays: forecastDays ?? this.forecastDays,
        forecastHours: forecastHours ?? this.forecastHours,
        forecastMinutely15: forecastMinutely15 ?? this.forecastMinutely15,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startHour: startHour ?? this.startHour,
        endHour: endHour ?? this.endHour,
        startMinutely15: startMinutely15 ?? this.startMinutely15,
        endMinutely15: endMinutely15 ?? this.endMinutely15,
      );

  Future<Map<String, dynamic>> rawRequest({
    required double latitude,
    required double longitude,
    List<HourlyEnsemble>? hourly,
  }) =>
      requestJson(this, _queryParamMap(latitude, longitude, hourly));

  Future<ApiResponse<EnsembleApi>> request({
    required double latitude,
    required double longitude,
    List<HourlyEnsemble>? hourly,
  }) =>
      requestFlatBuffer(this, _queryParamMap(latitude, longitude, hourly))
          .then((data) => ApiResponse.fromFlatBuffer(
                data,
                hourlyHashes: HourlyEnsemble.hashes,
              ));

  Map<String, dynamic> _queryParamMap(
    double latitude,
    double longitude,
    List<HourlyEnsemble>? hourly,
  ) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'models': models.map((value) => value.name),
        'hourly': hourly?.map((value) => value.name),
        'temperature_unit': temperatureUnit?.name,
        'windspeed_unit': windspeedUnit?.name,
        'precipitation_unit': precipitationUnit?.name,
        'cell_selection': cellSelection?.name,
        'elevation': elevation,
        'past_days': pastDays,
        'past_hours': pastHours,
        'past_minutely_15': pastMinutely15,
        'forecast_days': forecastDays,
        'forecast_hours': forecastHours,
        'forecast_minutely_15': forecastMinutely15,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'start_hour': formatTime(startHour),
        'end_hour': formatTime(endHour),
        'start_minytely_15': formatTime(startMinutely15),
        'end_minutely_15': formatTime(endMinutely15),
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

enum HourlyEnsemble with WeatherParameter<EnsembleApi, Hourly> {
  temperature_2m(Variable.temperature, altitude: 2),
  relative_humidity_2m(Variable.relative_humidity, altitude: 2),
  dew_point_2m(Variable.dew_point, altitude: 2),
  apparent_temperature(Variable.apparent_temperature, altitude: 2),
  precipitation(Variable.precipitation),
  rain(Variable.rain),
  snowfall(Variable.snowfall),
  snow_depth(Variable.snow_depth),
  weather_code(Variable.weather_code),
  pressure_msl(Variable.pressure_msl),
  surface_pressure(Variable.surface_pressure),
  cloud_cover(Variable.cloud_cover),
  visibility(Variable.visibility),
  et0_fao_evapotranspiration(Variable.et0_fao_evapotranspiration),
  vapour_pressure_deficit(Variable.vapour_pressure_deficit),
  wind_speed_10m(Variable.wind_speed, altitude: 10),
  wind_speed_80m(Variable.wind_speed, altitude: 80),
  wind_speed_120m(Variable.wind_speed, altitude: 120),
  wind_direction_10m(Variable.wind_direction, altitude: 10),
  wind_direction_80m(Variable.wind_direction, altitude: 80),
  wind_direction_120m(Variable.wind_direction, altitude: 120),
  wind_gusts_10m(Variable.wind_gusts, altitude: 10),
  temperature_80m(Variable.temperature, altitude: 80),
  temperature_120m(Variable.temperature, altitude: 120),
  surface_temperature(Variable.surface_temperature),
  soil_temperature_0_to_10cm(Variable.soil_temperature, depth: 0, depthTo: 10),
  soil_temperature_10_to_40cm(Variable.soil_temperature,
      depth: 10, depthTo: 40),
  soil_temperature_40_to_100cm(Variable.soil_temperature,
      depth: 40, depthTo: 100),
  soil_temperature_100_to_200cm(Variable.soil_temperature,
      depth: 100, depthTo: 200),
  soil_moisture_0_to_10cm(Variable.soil_moisture, depth: 0, depthTo: 10),
  soil_moisture_10_to_40cm(Variable.soil_moisture, depth: 10, depthTo: 40),
  soil_moisture_40_to_100cm(Variable.soil_moisture, depth: 40, depthTo: 100),
  soil_moisture_100_to_200cm(Variable.soil_moisture, depth: 100, depthTo: 200),
  uv_index(Variable.uv_index),
  uv_index_clear_sky(Variable.uv_index_clear_sky),
  temperature_500hPa(Variable.temperature, pressureLevel: 500),
  temperature_850hPa(Variable.temperature, pressureLevel: 850),
  geopotential_height_500hPa(Variable.geopotential_height, pressureLevel: 500),
  geopotential_height_850hPa(Variable.geopotential_height, pressureLevel: 850),
  cape(Variable.cape),
  freezing_level_height(Variable.freezing_level_height),
  sunshine_duration(Variable.sunshine_duration),
  shortwave_radiation(Variable.shortwave_radiation),
  direct_radiation(Variable.direct_radiation),
  diffuse_radiation(Variable.diffuse_radiation),
  direct_normal_irradiance(Variable.direct_normal_irradiance),
  global_tilted_irradiance(Variable.global_tilted_irradiance),
  shortwave_radiation_instant(Variable.shortwave_radiation_instant),
  direct_radiation_instant(Variable.direct_radiation_instant),
  diffuse_radiation_instant(Variable.diffuse_radiation_instant),
  direct_normal_irradiance_instant(Variable.direct_normal_irradiance_instant),
  global_tilted_irradiance_instant(Variable.global_tilted_irradiance_instant);

  @override
  final Variable variable;

  @override
  final int altitude;
  @override
  final int depth;
  @override
  final int depthTo;
  @override
  final int pressureLevel;

  const HourlyEnsemble(
    this.variable, {
    this.altitude = 0,
    this.depth = 0,
    this.depthTo = 0,
    this.pressureLevel = 0,
  });

  static final Map<int, HourlyEnsemble> hashes =
      makeHashes(HourlyEnsemble.values);
}

enum EnsembleModel {
  icon_seamless,
  icon_global,
  icon_eu,
  icon_d2,
  gfs_seamless,
  gfs025,
  gfs05,
  ecmwf_ifs04,
  gem_global,
  bom_access_global_ensemble,
}
