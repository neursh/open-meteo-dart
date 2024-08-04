import '../api.dart';
import '../enums/prefcls.dart';
import '../response.dart';
import '../utils.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

/// Explore Climate Change on a Local Level with High-Resolution Climate Data
///
/// https://open-meteo.com/en/docs/climate-api/
class ClimateApi extends BaseApi {
  final List<ClimateModel> models;

  final TemperatureUnit? temperatureUnit;
  final WindspeedUnit? windspeedUnit;
  final PrecipitationUnit? precipitationUnit;
  final CellSelection? cellSelection;

  final bool? disableBiasCorrection;

  ClimateApi({
    super.apiUrl = 'https://climate-api.open-meteo.com/v1/climate',
    super.apiKey,
    required this.models,
    this.temperatureUnit,
    this.windspeedUnit,
    this.precipitationUnit,
    this.cellSelection,
    this.disableBiasCorrection,
  });

  /// Create a HTTP request. The function will return JSON data as Map if successful.
  Future<Map<String, dynamic>> rawRequest({
    required double latitude,
    required double longitude,
    required DateTime startDate,
    required DateTime endDate,
    required List<DailyClimate> daily,
  }) =>
      requestJson(
          this, _queryParamMap(latitude, longitude, startDate, endDate, daily));

  Future<Response<ClimateApi>> request({
    required double latitude,
    required double longitude,
    required DateTime startDate,
    required DateTime endDate,
    required List<DailyClimate> daily,
  }) =>
      requestFlatBuffer(this,
              _queryParamMap(latitude, longitude, startDate, endDate, daily))
          .then((data) => Response.fromFlatBuffer(
                data,
                dailyHashes: DailyClimate.hashes,
              ));

  Map<String, dynamic> _queryParamMap(
    double latitude,
    double longitude,
    DateTime startDate,
    DateTime endDate,
    List<DailyClimate> daily,
  ) =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
        'daily': daily,
        'models': models,
        'temperature_unit': temperatureUnit,
        'windspeed_unit': windspeedUnit,
        'precipitation_unit': precipitationUnit,
        'cell_selection': cellSelection,
        'disable_bias_correction': disableBiasCorrection,
        'timeformat': 'unixtime',
        'timezone': 'auto',
      };
}

enum DailyClimate with WeatherParameter<ClimateApi, Daily> {
  temperature_2m_mean(Variable.temperature,
      altitude: 2, aggregation: Aggregation.mean),
  temperature_2m_max(Variable.temperature,
      altitude: 2, aggregation: Aggregation.maximum),
  temperature_2m_min(Variable.temperature,
      altitude: 2, aggregation: Aggregation.minimum),
  wind_speed_10m_mean(Variable.wind_speed,
      altitude: 10, aggregation: Aggregation.mean),
  wind_speed_10m_max(Variable.wind_speed,
      altitude: 10, aggregation: Aggregation.maximum),
  cloud_cover_mean(Variable.cloud_cover, aggregation: Aggregation.mean),
  shortwave_radiation_sum(Variable.shortwave_radiation,
      aggregation: Aggregation.sum),
  relative_humidity_2m_mean(Variable.relative_humidity,
      altitude: 2, aggregation: Aggregation.mean),
  relative_humidity_2m_max(Variable.relative_humidity,
      altitude: 2, aggregation: Aggregation.maximum),
  relative_humidity_2m_min(Variable.relative_humidity,
      altitude: 2, aggregation: Aggregation.minimum),
  dew_point_2m_mean(Variable.dew_point,
      altitude: 2, aggregation: Aggregation.mean),
  dew_point_2m_min(Variable.dew_point,
      altitude: 2, aggregation: Aggregation.maximum),
  dew_point_2m_max(Variable.dew_point,
      altitude: 2, aggregation: Aggregation.minimum),
  precipitation_sum(Variable.precipitation, aggregation: Aggregation.sum),
  rain_sum(Variable.rain, aggregation: Aggregation.sum),
  snowfall_sum(Variable.snowfall, aggregation: Aggregation.sum),
  pressure_msl_mean(Variable.pressure_msl, aggregation: Aggregation.mean),
  soil_moisture_0_to_10cm_mean(Variable.soil_moisture,
      depth: 0, depthTo: 10, aggregation: Aggregation.mean),
  et0_fao_evapotranspiration_sum(Variable.et0_fao_evapotranspiration,
      aggregation: Aggregation.sum);

  @override
  final Variable variable;

  @override
  final int altitude;
  @override
  final Aggregation aggregation;
  @override
  final int depth;
  @override
  final int depthTo;

  const DailyClimate(
    this.variable, {
    this.altitude = 0,
    this.aggregation = Aggregation.none,
    this.depth = 0,
    this.depthTo = 0,
  });

  static final Map<int, DailyClimate> hashes = makeHashes(DailyClimate.values);
}

enum ClimateModel {
  CMCC_CM2_VHR4,
  FGOALS_f3_H,
  HiRAM_SIT_HR,
  MRI_AGCM3_2_S,
  EC_Earth3P_HR,
  MPI_ESM1_2_XR,
  NICAM16_8S,
}
