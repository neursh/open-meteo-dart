import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:open_meteo/utils.dart';

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
  static Future<dynamic> search(
      {String apiUrl = "https://geocoding-api.open-meteo.com/v1/",
      required String name,
      int? count,
      String? language,
      String? apikey}) async {
    Uri.parse(apiUrl);
    if (name.isEmpty) {
      return {};
    }

    String args = (createNullableParam("name", name) +
            createNullableParam("count", count) +
            createNullableParam("language", language) +
            createNullableParam("apikey", apikey))
        .replaceFirst("&", "");

    return jsonDecode(
        (await http.get(Uri.parse("${apiUrl}search?$args"))).body);
  }
}
