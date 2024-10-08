import '../api.dart';

/// 90 meter resolution digital elevation model.
///
/// https://open-meteo.com/en/docs/elevation-api/
class ElevationApi extends BaseApi {
  const ElevationApi({
    super.apiUrl = 'https://api.open-meteo.com/v1/elevation',
    super.apiKey,
  });

  ElevationApi copyWith({
    String? apiUrl,
    String? apiKey,
  }) =>
      ElevationApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  Future<Map<String, dynamic>> requestJson({
    required List<double> latitudes,
    required List<double> longitudes,
  }) =>
      apiRequestJson(this, {
        'latitude': latitudes,
        'longitude': longitudes,
      });
}
