import 'package:http/http.dart' as http;
import 'dart:convert';

class Geocoding {
  /// Search locations in any language globally.
  ///
  /// | attributes | type    |
  /// |------------|---------|
  /// | name       | String  |
  /// | count      | int?    |
  /// | language   | String? |
  ///
  /// If `name` attributes is empty, this function will return `{}`
  ///
  /// [Return object format](https://open-meteo.com/en/docs/geocoding-api#api-documentation)
  static Future<dynamic> search(
      {required String name, int? count, String? language}) async {
    if (name.isEmpty) {
      return {};
    }
    return jsonDecode((await http.get(Uri.parse(
            "https://geocoding-api.open-meteo.com/v1/search?name=$name${count != null ? "&count=$count" : ""}${language != null ? "&language=$language" : ""}")))
        .body);
  }
}
