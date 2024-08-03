import '../utils.dart';

/// 90 meter resolution digital elevation model.
///
/// https://open-meteo.com/en/docs/elevation-api/
class Elevation {
  final String apiUrl;
  final String? apiKey;

  const Elevation({
    this.apiUrl = 'https://api.open-meteo.com/v1/',
    this.apiKey,
  });

  /// `latitude`, `longitude`: Geographical WGS84 coordinates of the location. Can be multiple coordinates.
  /// `apiUrl`: Custom API URL, format: `https://<domain>/<version>/`.
  /// `apikey`: Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/elevation-api/
  Future<Map<String, dynamic>> request({
    required List<double> latitudes,
    required List<double> longitudes,
  }) =>
      sendHttpRequest(apiUrl, 'elevation', {
        'latitude': latitudes.join(','),
        'longitude': longitudes.join(','),
        'apikey': apiKey,
      });
}
