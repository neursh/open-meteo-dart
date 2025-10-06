import '../api.dart';

/// Search locations globally in any language.
///
/// https://open-meteo.com/en/docs/geocoding-api/
class GeocodingApi extends BaseApi {
  final String language;

  const GeocodingApi({
    super.apiUrl = 'https://geocoding-api.open-meteo.com/v1/search',
    super.apiKey,
    super.userAgent,
    this.language = 'en',
  });

  GeocodingApi copyWith({
    String? apiUrl,
    String? apiKey,
    String? userAgent,
    String? language,
  }) =>
      GeocodingApi(
        apiUrl: apiUrl ?? this.apiUrl,
        apiKey: apiKey ?? this.apiKey,
        userAgent: userAgent ?? this.userAgent,
        language: language ?? this.language,
      );

  /// This method returns a JSON map,
  /// containing either the data or the raw error response.
  Future<Map<String, dynamic>> requestJson({
    required String name,
    int? count,
    Uri Function(Uri)? overrideUri,
  }) =>
      apiRequestJson(
        this,
        {
          'name': name,
          'count': count,
          'language': nullIfEqual(language, 'en'),
        },
        overrideUri,
      );
}
