import 'package:open_meteo/open_meteo.dart';

void main() async {
  var op = Weather(
      latitude: 52.52,
      longitude: 13.41,
      start_date: DateTime.now(),
      end_date: DateTime.now().add(const Duration(days: 1)));
  var whourly = [Hourly.temperature_2m];
  var res = await op.raw_request(hourly: whourly);
  print(res);
}
