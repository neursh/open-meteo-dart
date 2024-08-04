import '../api.dart';

/// 90 meter resolution digital elevation model.
///
/// https://open-meteo.com/en/docs/elevation-api/
class Elevation extends BaseApi {
  Elevation({
    super.apiUrl = 'https://api.open-meteo.com/v1/elevation',
    super.apiKey,
  });

  Elevation copyWith({
    String? apiUrl,
    String? apiKey,
  }) =>
      Elevation(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
      );

  Future<Map<String, dynamic>> request({
    required List<double> latitudes,
    required List<double> longitudes,
  }) =>
      requestJson(this, {
        'latitude': latitudes,
        'longitude': longitudes,
      });
}
