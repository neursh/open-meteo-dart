// ignore_for_file: non_constant_identifier_names

class Hourly {
  /// A class to specify what you want out of the API for hourly infomations.
  ///
  /// | attributes                 | type  |
  /// |----------------------------|-------|
  /// | temperature_2m             | bool? |
  /// | temperature_80m            | bool? |
  /// | temperature_120m           | bool? |
  /// | temperature_180m           | bool? |
  /// | relativehumidity_2m        | bool? |
  /// | dewpoint_2m                | bool? |
  /// | apparent_temperature       | bool? |
  /// | pressure_msl               | bool? |
  /// | surface_pressure           | bool? |
  /// | cloudcover                 | bool? |
  /// | cloudcover_low             | bool? |
  /// | cloudcover_mid             | bool? |
  /// | cloudcover_high            | bool? |
  /// | windspeed_10m              | bool? |
  /// | windspeed_80m              | bool? |
  /// | windspeed_120m             | bool? |
  /// | windspeed_180m             | bool? |
  /// | winddirection_10m          | bool? |
  /// | winddirection_80m          | bool? |
  /// | winddirection_120m         | bool? |
  /// | winddirection_180m         | bool? |
  /// | windgusts_10m              | bool? |
  /// | shortwave_radiation        | bool? |
  /// | direct_radiation           | bool? |
  /// | direct_normal_irradiance   | bool? |
  /// | diffuse_radiation          | bool? |
  /// | vapor_pressure_deficit     | bool? |
  /// | cape                       | bool? |
  /// | evapotranspiration         | bool? |
  /// | et0_fao_evapotranspiration | bool? |
  /// | precipitation              | bool? |
  /// | snowfall                   | bool? |
  /// | rain                       | bool? |
  /// | showers                    | bool? |
  /// | weathercode                | bool? |
  /// | snow_depth                 | bool? |
  /// | freezinglevel_height       | bool? |
  /// | visibility                 | bool? |
  /// | soil_temperature_0cm       | bool? |
  /// | soil_temperature_6cm       | bool? |
  /// | soil_temperature_18cm      | bool? |
  /// | soil_temperature_54cm      | bool? |
  /// | soil_moisture_0_1cm        | bool? |
  /// | soil_moisture_1_3cm        | bool? |
  /// | soil_moisture_3_9cm        | bool? |
  /// | soil_moisture_9_27cm       | bool? |
  /// | soil_moisture_27_81cm      | bool? |
  /// | all                        | bool? |
  ///
  /// `all` attribute to get all ifnomations.
  ///
  /// Example:
  ///
  /// ```
  /// Hourly temp_cloud = Hourly(temperature_2m: true, cloudcover: true);
  /// ```
  ///
  /// To learn more about what are these attributes mean, go to [OpenMeteo's docs](https://open-meteo.com/en/docs).
  bool? temperature_2m,
      temperature_80m,
      temperature_120m,
      temperature_180m,
      relativehumidity_2m,
      dewpoint_2m,
      apparent_temperature,
      pressure_msl,
      surface_pressure,
      cloudcover,
      cloudcover_low,
      cloudcover_mid,
      cloudcover_high,
      windspeed_10m,
      windspeed_80m,
      windspeed_120m,
      windspeed_180m,
      winddirection_10m,
      winddirection_80m,
      winddirection_120m,
      winddirection_180m,
      windgusts_10m,
      shortwave_radiation,
      direct_radiation,
      direct_normal_irradiance,
      diffuse_radiation,
      vapor_pressure_deficit,
      cape,
      evapotranspiration,
      et0_fao_evapotranspiration,
      precipitation,
      snowfall,
      rain,
      showers,
      weathercode,
      snow_depth,
      freezinglevel_height,
      visibility,
      soil_temperature_0cm,
      soil_temperature_6cm,
      soil_temperature_18cm,
      soil_temperature_54cm,
      soil_moisture_0_1cm,
      soil_moisture_1_3cm,
      soil_moisture_3_9cm,
      soil_moisture_9_27cm,
      soil_moisture_27_81cm,
      all;
  Hourly(
      {this.temperature_2m,
      this.temperature_80m,
      this.temperature_120m,
      this.temperature_180m,
      this.relativehumidity_2m,
      this.dewpoint_2m,
      this.apparent_temperature,
      this.pressure_msl,
      this.surface_pressure,
      this.cloudcover,
      this.cloudcover_low,
      this.cloudcover_mid,
      this.cloudcover_high,
      this.windspeed_10m,
      this.windspeed_80m,
      this.windspeed_120m,
      this.windspeed_180m,
      this.winddirection_10m,
      this.winddirection_80m,
      this.winddirection_120m,
      this.winddirection_180m,
      this.windgusts_10m,
      this.shortwave_radiation,
      this.direct_radiation,
      this.direct_normal_irradiance,
      this.diffuse_radiation,
      this.vapor_pressure_deficit,
      this.cape,
      this.evapotranspiration,
      this.et0_fao_evapotranspiration,
      this.precipitation,
      this.snowfall,
      this.rain,
      this.showers,
      this.weathercode,
      this.snow_depth,
      this.freezinglevel_height,
      this.visibility,
      this.soil_temperature_0cm,
      this.soil_temperature_6cm,
      this.soil_temperature_18cm,
      this.soil_temperature_54cm,
      this.soil_moisture_0_1cm,
      this.soil_moisture_1_3cm,
      this.soil_moisture_3_9cm,
      this.soil_moisture_9_27cm,
      this.soil_moisture_27_81cm,
      this.all}) {
    temperature_2m = temperature_2m ?? false;
    temperature_80m = temperature_80m ?? false;
    temperature_120m = temperature_120m ?? false;
    temperature_180m = temperature_180m ?? false;
    relativehumidity_2m = relativehumidity_2m ?? false;
    dewpoint_2m = dewpoint_2m ?? false;
    apparent_temperature = apparent_temperature ?? false;
    precipitation = precipitation ?? false;
    rain = rain ?? false;
    showers = showers ?? false;
    snowfall = snowfall ?? false;
    snow_depth = snow_depth ?? false;
    freezinglevel_height = freezinglevel_height ?? false;
    weathercode = weathercode ?? false;
    pressure_msl = pressure_msl ?? false;
    surface_pressure = surface_pressure ?? false;
    cloudcover = cloudcover ?? false;
    cloudcover_low = cloudcover_low ?? false;
    cloudcover_mid = cloudcover_mid ?? false;
    cloudcover_high = cloudcover_high ?? false;
    visibility = visibility ?? false;
    evapotranspiration = evapotranspiration ?? false;
    et0_fao_evapotranspiration = et0_fao_evapotranspiration ?? false;
    vapor_pressure_deficit = vapor_pressure_deficit ?? false;
    cape = cape ?? false;
    windspeed_10m = windspeed_10m ?? false;
    windspeed_80m = windspeed_80m ?? false;
    windspeed_120m = windspeed_120m ?? false;
    windspeed_180m = windspeed_180m ?? false;
    winddirection_10m = winddirection_10m ?? false;
    winddirection_80m = winddirection_80m ?? false;
    winddirection_120m = winddirection_120m ?? false;
    winddirection_180m = winddirection_180m ?? false;
    windgusts_10m = windgusts_10m ?? false;
    soil_temperature_0cm = soil_temperature_0cm ?? false;
    soil_temperature_6cm = soil_temperature_6cm ?? false;
    soil_temperature_18cm = soil_temperature_18cm ?? false;
    soil_temperature_54cm = soil_temperature_54cm ?? false;
    soil_moisture_0_1cm = soil_moisture_0_1cm ?? false;
    soil_moisture_1_3cm = soil_moisture_1_3cm ?? false;
    soil_moisture_3_9cm = soil_moisture_3_9cm ?? false;
    soil_moisture_9_27cm = soil_moisture_9_27cm ?? false;
    soil_moisture_27_81cm = soil_moisture_27_81cm ?? false;
    all = all ?? false;
  }
}