import 'package:open_meteo/open_meteo.dart';

void main() async {
  final api = WeatherApi();
  final response = await api.request(
    latitude: 52.52,
    longitude: 13.41,
    current: {WeatherCurrent.temperature_2m},
  );
  final data = response.currentData[WeatherCurrent.temperature_2m]!;
  final currentTemperature = data.value;
  print(currentTemperature);
}
