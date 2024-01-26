import 'package:open_meteo/open_meteo.dart';

void main() async {
  var weather = Weather(latitude: 52.52, longitude: 13.41);
  var hourly = [Hourly.temperature_2m];
  var result = await weather.raw_request(hourly: hourly);
  print(result);
}
