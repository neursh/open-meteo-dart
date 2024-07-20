import '../utils.dart';

/// 90 meter resolution digital elevation model.
///
/// https://open-meteo.com/en/docs/elevation-api/
class Elevation {
  /// `latitude`, `longitude`: Geographical WGS84 coordinates of the location. Can be multiple coordinates.
  /// `apiUrl`: Custom API URL, format: `https://<domain>/<version>/`.
  /// `apikey`: Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/elevation-api/
  static Future<dynamic> search({
    String apiUrl = 'https://api.open-meteo.com/v1/',
    required List<double> latitudes,
    required List<double> longitudes,
    String? apikey,
  }) =>
      sendHttpRequest(apiUrl, 'elevation', {
        'latitude': latitudes.join(','),
        'longitude': longitudes.join(','),
        'apikey': apikey,
      });
}
