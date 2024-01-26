import 'package:open_meteo/open_meteo.dart';

void main() async {
  var op = Forecast(latitude: 52.52, longitude: 13.41);
  var hourly = [Hourly.temperature_2m];
  var res = await op.raw_request(hourly: hourly);
  print(res);
}
