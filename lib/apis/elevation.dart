import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:open_meteo/utils.dart';

/// 90 meter resolution digital elevation model.
///
/// https://open-meteo.com/en/docs/elevation-api/
class Elevation {
  /// `latitude`, `longitude`: Geographical WGS84 coordinates of the location. Can be multiple coordinates.
  /// `apiUrl`: Custom API URL, format: `https://<domain>/<version>/`.
  /// `apikey`: Only required to commercial use to access reserved API resources for customers.
  ///
  /// https://open-meteo.com/en/docs/elevation-api/
  static Future<dynamic> search(
      {String apiUrl = "https://api.open-meteo.com/v1/",
      required List<double> latitudes,
      longitudes,
      String? apikey}) async {
    Uri.parse(apiUrl);
    String args = (createNullableParam("latitude", latitudes.join(",")) +
            createNullableParam("longitude", longitudes.join(",")) +
            createNullableParam("apikey", apikey))
        .replaceFirst("&", "");

    return jsonDecode(
        (await http.get(Uri.parse("${apiUrl}elevation?$args"))).body);
  }
}
