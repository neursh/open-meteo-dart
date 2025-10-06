/// Temperature unit.
enum TemperatureUnit {
  celsius,
  fahrenheit;
}

/// Wind speed unit.
enum WindspeedUnit {
  kmh,
  ms,
  mph,
  kn;
}

/// Precipitation amount unit.
enum PrecipitationUnit {
  mm,
  inch;
}

/// Metric and imperial.
enum LengthUnit {
  metric,
  imperial;
}

/// Set a preference how grid-cells are selected.
enum CellSelection {
  /// Selects suitable grid-cell on land with similar elevation to the requested coordinates using a 90-meter digital elevation model.
  land,

  /// Prefers grid-cells on sea.
  sea,

  /// Selects the nearest possible grid-cell.
  nearest;
}

class OpenMeteoLocation {
  final double latitude;
  final double longitude;
  final double? elevation;
  final DateTime? startDate;
  final DateTime? endDate;

  const OpenMeteoLocation({
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.startDate,
    this.endDate,
  });
}
