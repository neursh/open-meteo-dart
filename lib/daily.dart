// ignore_for_file: non_constant_identifier_names

class Daily {
  /// A class to specify what you want out of the API for daily infomations.
  ///
  /// | attributes                 | type  |
  /// |----------------------------|-------|
  /// | weathercode                | bool? |
  /// | temperature_2m_max         | bool? |
  /// | temperature_2m_min         | bool? |
  /// | apparent_temperature_max   | bool? |
  /// | apparent_temperature_min   | bool? |
  /// | sunrise                    | bool? |
  /// | sunset                     | bool? |
  /// | precipitation_sum          | bool? |
  /// | rain_sum                   | bool? |
  /// | showers_sum                | bool? |
  /// | snowfall_sum               | bool? |
  /// | precipitation_hours        | bool? |
  /// | windspeed_10m_max          | bool? |
  /// | windgusts_10m_max          | bool? |
  /// | winddirection_10m_dominant | bool? |
  /// | shortwave_radiation_sum    | bool? |
  /// | et0_fao_evapotranspiration | bool? |
  /// | all                        | bool? |
  ///
  /// `all` attribute to get all ifnomations.
  ///
  /// Example:
  ///
  /// ```
  /// Daily sun_moon = Daily(sunrise: true, sunset: true);
  /// ```
  ///
  /// To learn more what are these attributes mean, go to [OpenMeteo's docs](https://open-meteo.com/en/docs).
  bool? weathercode,
      temperature_2m_max,
      temperature_2m_min,
      apparent_temperature_max,
      apparent_temperature_min,
      sunrise,
      sunset,
      precipitation_sum,
      rain_sum,
      showers_sum,
      snowfall_sum,
      precipitation_hours,
      windspeed_10m_max,
      windgusts_10m_max,
      winddirection_10m_dominant,
      shortwave_radiation_sum,
      et0_fao_evapotranspiration,
      uv_index_max,
      uv_index_clear_sky_max,
      all;
  Daily(
      {this.weathercode,
      this.temperature_2m_max,
      this.temperature_2m_min,
      this.apparent_temperature_max,
      this.apparent_temperature_min,
      this.sunrise,
      this.sunset,
      this.precipitation_sum,
      this.rain_sum,
      this.showers_sum,
      this.snowfall_sum,
      this.precipitation_hours,
      this.windspeed_10m_max,
      this.windgusts_10m_max,
      this.winddirection_10m_dominant,
      this.shortwave_radiation_sum,
      this.et0_fao_evapotranspiration,
      this.uv_index_max,
      this.uv_index_clear_sky_max,
      this.all}) {
    weathercode = weathercode ?? false;
    temperature_2m_max = temperature_2m_max ?? false;
    temperature_2m_min = temperature_2m_min ?? false;
    apparent_temperature_max = apparent_temperature_max ?? false;
    apparent_temperature_min = apparent_temperature_min ?? false;
    sunrise = sunrise ?? false;
    sunset = sunset ?? false;
    precipitation_sum = precipitation_sum ?? false;
    rain_sum = rain_sum ?? false;
    showers_sum = showers_sum ?? false;
    snowfall_sum = snowfall_sum ?? false;
    precipitation_hours = precipitation_hours ?? false;
    windspeed_10m_max = windspeed_10m_max ?? false;
    windgusts_10m_max = windgusts_10m_max ?? false;
    winddirection_10m_dominant = winddirection_10m_dominant ?? false;
    shortwave_radiation_sum = shortwave_radiation_sum ?? false;
    et0_fao_evapotranspiration = et0_fao_evapotranspiration ?? false;
    uv_index_max = uv_index_max ?? false;
    uv_index_clear_sky_max = uv_index_clear_sky_max ?? false;
    all = all ?? false;
  }
}
