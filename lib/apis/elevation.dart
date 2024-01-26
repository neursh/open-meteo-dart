import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:open_meteo/utils.dart';

class Elevation {
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
