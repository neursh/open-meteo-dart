import 'dart:convert';

import 'package:http/http.dart' as http;

import 'exceptions/invalid_data.dart';

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
  return jsonDecode((await http.get(url)).body);
}
