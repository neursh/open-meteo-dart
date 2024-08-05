import 'package:open_meteo/open_meteo.dart';

void main() async {
  WeatherApi weather = WeatherApi(
    temperatureUnit: TemperatureUnit.celsius,
  );
  ApiResponse<WeatherApi> result = await weather.request(
    latitude: 52.52,
    longitude: 13.41,
    current: [CurrentWeather.temperature_2m],
  );
  ParameterData temperature =
      result.currentData[CurrentWeather.temperature_2m]!;
  double currentTemperature = temperature.data.values.first;

  print(currentTemperature);
}
