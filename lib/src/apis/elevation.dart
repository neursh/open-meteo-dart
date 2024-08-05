import '../api.dart';

/// 90 meter resolution digital elevation model.
///
/// https://open-meteo.com/en/docs/elevation-api/
class ElevationApi extends BaseApi {
  ElevationApi({
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

  Future<Map<String, dynamic>> requestJson({
    required List<double> latitudes,
    required List<double> longitudes,
  }) =>
      apiRequestJson(this, {
        'latitude': latitudes,
        'longitude': longitudes,
      });
}
