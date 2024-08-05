import '../api.dart';
import '../apis/air_quality.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

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

enum AirQualityDomains {
  cams_europe,
  cams_global;
}
