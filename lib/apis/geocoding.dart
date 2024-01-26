import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:open_meteo/utils.dart';

/// Search locations globally in any language.
///
/// https://open-meteo.com/en/docs/geocoding-api/
class Geocoding {
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

    String args = (createNullableParam(name, "name") +
            createNullableParam("count", count) +
            createNullableParam("language", language) +
            createNullableParam("apikey", apikey))
        .replaceFirst("&", "");

    return jsonDecode(
        (await http.get(Uri.parse("${apiUrl}search?$args"))).body);
  }
}
