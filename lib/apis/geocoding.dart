import '../utils.dart';

/// Search locations globally in any language.
///
/// https://open-meteo.com/en/docs/geocoding-api/
class Geocoding {
  /// `name`: String to search for. An empty string or only 1 character will
  /// return an empty result. 2 characters will only match exact matching locations.
  /// 3 and more characters will perform fuzzy matching. The search string can be a location name or a postal code.
  /// `count`: The number of search results to return. Up to 100 results can be retrieved.
  /// `language`: Return translated results, if available, otherwise return english or the native location name. Lower-cased.
  /// `apiUrl`: Custom API URL, format: `https://<domain>/<version>/`.
  /// `apikey`: Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/elevation-api/
  static Future<Map> search({
    String apiUrl = 'https://geocoding-api.open-meteo.com/v1/',
    required String name,
    int? count,
    String? language,
    String? apikey,
  }) {
    Uri.parse(apiUrl);
    if (name.isEmpty) {
      return Future.value({});
    }

    return sendHttpRequest(apiUrl, 'search', {
      'name': name,
      'count': count,
      'language': language,
      'apikey': apikey,
    });
  }
}
