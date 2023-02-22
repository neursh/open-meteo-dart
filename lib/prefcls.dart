class TemperatureUnit {
  /// Set response's temperature unit.
  ///
  /// Example (set response's temperature unit to fahrenheit):
  ///
  /// ```
  /// OpenMeteo(
  /// ...
  ///   temperature_unit: TemperatureUnit.fahrenheit
  /// )
  /// ```
  static TemperatureUnit celsius = TemperatureUnit(type: "celsius"),
      fahrenheit = TemperatureUnit(type: "fahrenheit");

  String type;
  TemperatureUnit({required this.type});
}

class WindspeedUnit {
  /// Set response's windspeed unit.
  ///
  /// Example (set response's windspeed unit to m/s):
  ///
  /// ```
  /// OpenMeteo(
  /// ...
  ///   windspeed_unit: WindspeedUnit.ms
  /// )
  /// ```
  static WindspeedUnit kmh = WindspeedUnit(type: "kmh"),
      ms = WindspeedUnit(type: "ms"),
      mph = WindspeedUnit(type: "mph"),
      kn = WindspeedUnit(type: "kn");

  String type;
  WindspeedUnit({required this.type});
}

class PrecipitationUnit {
  /// Set response's precipitation unit.
  ///
  /// Example (set response's precipitation unit to inch):
  ///
  /// ```
  /// OpenMeteo(
  /// ...
  ///   precipitation_unit: PrecipitationUnit.inch
  /// )
  /// ```
  static PrecipitationUnit mm = PrecipitationUnit(type: "mm"),
      inch = PrecipitationUnit(type: "inch");

  String type;
  PrecipitationUnit({required this.type});
}