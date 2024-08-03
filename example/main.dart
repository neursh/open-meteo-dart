import 'package:open_meteo/open_meteo.dart';

void main() async {
  WeatherApi weather = WeatherApi(
    temperatureUnit: TemperatureUnit.celsius,
  );
  Response<WeatherApi> result = await weather.request(
    latitude: 52.52,
    longitude: 13.41,
    // current: [Current.temperature_2m],
    current: [CurrentWeather.temperature_2m],
  );
  print(result.currentWeatherData);
  // WeatherParameterData temperature =
  //     result.currentWeatherData![Current.temperature_2m]!;
  // double currentTemperature = temperature.data.values.first;

  // print(currentTemperature);
}
