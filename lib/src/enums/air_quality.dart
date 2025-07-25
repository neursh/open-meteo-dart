import '../api.dart';
import '../apis/air_quality.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

// Generated Variable Enums for AirQuality

enum AirQualityCurrent with Parameter<AirQualityApi, Current> {
  european_aqi(
    Variable.european_aqi,
  ),
  us_aqi(
    Variable.us_aqi,
  ),
  pm10(
    Variable.pm10,
  ),
  pm2_5(
    Variable.pm2p5,
  ),
  carbon_monoxide(
    Variable.carbon_monoxide,
  ),
  nitrogen_dioxide(
    Variable.nitrogen_dioxide,
  ),
  sulphur_dioxide(
    Variable.sulphur_dioxide,
  ),
  ozone(
    Variable.ozone,
  ),
  aerosol_optical_depth(
    Variable.aerosol_optical_depth,
  ),
  dust(
    Variable.dust,
  ),
  uv_index(
    Variable.uv_index,
  ),
  uv_index_clear_sky(
    Variable.uv_index_clear_sky,
  ),
  ammonia(
    Variable.ammonia,
  ),
  alder_pollen(
    Variable.alder_pollen,
  ),
  birch_pollen(
    Variable.birch_pollen,
  ),
  grass_pollen(
    Variable.grass_pollen,
  ),
  mugwort_pollen(
    Variable.mugwort_pollen,
  ),
  olive_pollen(
    Variable.olive_pollen,
  ),
  ragweed_pollen(
    Variable.ragweed_pollen,
  ),
  ;

  @override
  final Variable variable;
  const AirQualityCurrent(this.variable);

  static final Map<int, AirQualityCurrent> hashes =
      makeHashes(AirQualityCurrent.values);
}

enum AirQualityHourly with Parameter<AirQualityApi, Hourly> {
  pm10(
    Variable.pm10,
  ),
  pm2_5(
    Variable.pm2p5,
  ),
  carbon_monoxide(
    Variable.carbon_monoxide,
  ),
  carbon_dioxide(
    Variable.carbon_dioxide,
  ),
  nitrogen_dioxide(
    Variable.nitrogen_dioxide,
  ),
  sulphur_dioxide(
    Variable.sulphur_dioxide,
  ),
  ozone(
    Variable.ozone,
  ),
  aerosol_optical_depth(
    Variable.aerosol_optical_depth,
  ),
  dust(
    Variable.dust,
  ),
  uv_index(
    Variable.uv_index,
  ),
  uv_index_clear_sky(
    Variable.uv_index_clear_sky,
  ),
  ammonia(
    Variable.ammonia,
  ),
  methane(
    Variable.methane,
  ),
  alder_pollen(
    Variable.alder_pollen,
  ),
  birch_pollen(
    Variable.birch_pollen,
  ),
  grass_pollen(
    Variable.grass_pollen,
  ),
  mugwort_pollen(
    Variable.mugwort_pollen,
  ),
  olive_pollen(
    Variable.olive_pollen,
  ),
  ragweed_pollen(
    Variable.ragweed_pollen,
  ),
  european_aqi(
    Variable.european_aqi,
  ),
  european_aqi_pm2_5(
    Variable.european_aqi_pm2p5,
  ),
  european_aqi_pm10(
    Variable.european_aqi_pm10,
  ),
  european_aqi_nitrogen_dioxide(
    Variable.european_aqi_nitrogen_dioxide,
  ),
  european_aqi_ozone(
    Variable.european_aqi_ozone,
  ),
  european_aqi_sulphur_dioxide(
    Variable.european_aqi_sulphur_dioxide,
  ),
  us_aqi(
    Variable.us_aqi,
  ),
  us_aqi_pm2_5(
    Variable.us_aqi_pm2p5,
  ),
  us_aqi_pm10(
    Variable.us_aqi_pm10,
  ),
  us_aqi_nitrogen_dioxide(
    Variable.us_aqi_nitrogen_dioxide,
  ),
  us_aqi_carbon_monoxide(
    Variable.us_aqi_carbon_monoxide,
  ),
  us_aqi_ozone(
    Variable.us_aqi_ozone,
  ),
  us_aqi_sulphur_dioxide(
    Variable.us_aqi_sulphur_dioxide,
  ),
  formaldehyde(
    Variable.formaldehyde,
  ),
  glyoxal(
    Variable.glyoxal,
  ),
  non_methane_volatile_organic_compounds(
    Variable.non_methane_volatile_organic_compounds,
  ),
  pm10_wildfires(
    Variable.pm10_wildfires,
  ),
  peroxyacyl_nitrates(
    Variable.peroxyacyl_nitrates,
  ),
  secondary_inorganic_aerosol(
    Variable.secondary_inorganic_aerosol,
  ),
  residential_elementary_carbon(
    Variable.residential_elementary_carbon,
  ),
  total_elementary_carbon(
    Variable.total_elementary_carbon,
  ),
  sea_salt_aerosol(
    Variable.sea_salt_aerosol,
  ),
  nitrogen_monoxide(
    Variable.nitrogen_monoxide,
  ),
  ;

  @override
  final Variable variable;
  const AirQualityHourly(this.variable);

  static final Map<int, AirQualityHourly> hashes =
      makeHashes(AirQualityHourly.values);
}

enum AirQualityDomains {
  auto,
  cams_europe,
  cams_global;
}
