import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'exceptions.dart';

String? formatDate(DateTime? date) => date?.toIso8601String().substring(0, 10);
String? formatTime(DateTime? time) => time?.toIso8601String();

void throwCheckLatLng(double latitude, longitude) {
  if (latitude < -90 || latitude > 90) {
    throw InvalidDataException('Provided latitude must be in range -90 to 90');
  }
  if (longitude < -180 || longitude > 180) {
    throw InvalidDataException(
        'Provided longitude must be in range -180 to 180');
  }
}

Future<Map<String, dynamic>> sendHttpRequest(
    String baseUrl, String path, Map<String, dynamic> queryParams) async {
  String query = queryParams.entries
      .where((entry) => entry.value != null)
      .map((entry) => '${entry.key}=${entry.value}')
      .join('&');
  Uri url = Uri.parse('$baseUrl$path?$query');
  print("[open_meteo] Parsed URL: ${url.toString()}");
  return jsonDecode((await http.get(url)).body);
}

Future<Uint8List> sendApiRequest(
  String baseUrl,
  String path,
  Map<String, dynamic> queryParams,
) async {
  String query = queryParams.entries
      .followedBy({
        'format': 'flatbuffers',
      }.entries)
      .where((entry) => entry.value != null)
      .map((entry) => '${entry.key}=${entry.value}')
      .join('&');

  Uri url = Uri.parse('$baseUrl$path?$query');
  print("[open_meteo] Parsed URL: ${url.toString()}");

  http.Response response = await http.get(url);
  if (response.statusCode != 200) {
    throw OpenMeteoApiError(jsonDecode(response.body)['reason']);
  }

  return response.bodyBytes;
}
