import '../api.dart';
import '../apis/satellite_radiation.dart';
import '../weather_api_openmeteo_sdk_generated.dart';

// Generated Variable Enums for SatelliteRadiation

enum SatelliteRadiationHourly with Parameter<SatelliteRadiationApi, Hourly> {
  shortwave_radiation(
    Variable.shortwave_radiation,
  ),
  direct_radiation(
    Variable.direct_radiation,
  ),
  diffuse_radiation(
    Variable.diffuse_radiation,
  ),
  direct_normal_irradiance(
    Variable.direct_normal_irradiance,
  ),
  global_tilted_irradiance(
    Variable.global_tilted_irradiance,
  ),
  terrestrial_radiation(
    Variable.terrestrial_radiation,
  ),
  shortwave_radiation_instant(
    Variable.shortwave_radiation_instant,
  ),
  direct_radiation_instant(
    Variable.direct_radiation_instant,
  ),
  diffuse_radiation_instant(
    Variable.diffuse_radiation_instant,
  ),
  direct_normal_irradiance_instant(
    Variable.direct_normal_irradiance_instant,
  ),
  global_tilted_irradiance_instant(
    Variable.global_tilted_irradiance_instant,
  ),
  terrestrial_radiation_instant(
    Variable.terrestrial_radiation_instant,
  ),
  is_day(
    Variable.is_day,
  ),
  sunshine_duration(
    Variable.sunshine_duration,
  ),
  ;

  @override
  final Variable variable;
  const SatelliteRadiationHourly(this.variable);

  static final Map<int, SatelliteRadiationHourly> hashes =
      makeHashes(SatelliteRadiationHourly.values);
}

enum SatelliteRadiationDaily with Parameter<SatelliteRadiationApi, Daily> {
  sunrise(
    Variable.sunrise,
  ),
  sunset(
    Variable.sunset,
  ),
  daylight_duration(
    Variable.daylight_duration,
  ),
  sunshine_duration(
    Variable.sunshine_duration,
  ),
  shortwave_radiation_sum(
    Variable.shortwave_radiation,
    aggregation: Aggregation.sum,
  ),
  ;

  @override
  final Variable variable;
  @override
  final Aggregation aggregation;
  const SatelliteRadiationDaily(
    this.variable, {
    this.aggregation = Aggregation.none,
  });

  static final Map<int, SatelliteRadiationDaily> hashes =
      makeHashes(SatelliteRadiationDaily.values);
}

enum SatelliteRadiationModels {
  satellite_radiation_seamless,
  eumetsat_lsa_saf_msg,
  eumetsat_lsa_saf_iodc,
  eumetsat_sarah3,
  jma_jaxa_himawari,
  ecmwf_ifs,
  era5_seamless,
  era5,
  era5_land,
  era5_ensemble,
  cerra,
  gem_seamless,
  gem_global,
  gem_regional,
  gem_hrdps_continental,
  metno_seamless,
  knmi_harmonie_arome_europe,
  knmi_seamless,
  dmi_seamless,
  knmi_harmonie_arome_netherlands,
  dmi_harmonie_arome_europe,
  ukmo_uk_deterministic_2km,
  ukmo_global_deterministic_10km,
  ukmo_seamless,
  metno_nordic,
  icon_d2,
  icon_eu,
  icon_global,
  icon_seamless,
  bom_access_global,
  cma_grapes_global,
  ecmwf_aifs025_single,
  best_match,
  ecmwf_ifs025,
  gfs_seamless,
  gfs_global,
  gfs_hrrr,
  ncep_nbm_conus,
  gfs_graphcast025,
  jma_seamless,
  jma_msm,
  jma_gsm,
  kma_seamless,
  kma_ldps,
  kma_gdps,
  italia_meteo_arpae_icon_2i,
  meteofrance_seamless,
  meteofrance_arpege_world,
  meteofrance_arpege_europe,
  meteofrance_arome_france,
  meteofrance_arome_france_hd
}
