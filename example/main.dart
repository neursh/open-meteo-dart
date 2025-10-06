import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi(
    userAgent: "My-Flutter-App",
    temperatureUnit: TemperatureUnit.celsius,
  );
  final response = await weather.request(
    locations: {
      OpenMeteoLocation(
        latitude: 16.16667,
        longitude: 107.83333,
        startDate: DateTime(2025, 10, 1),
        endDate: DateTime(2025, 10, 6),
      )
    },
    hourly: {WeatherHourly.temperature_2m},
  );
  final data = response.segments[0].hourlyData[WeatherHourly.temperature_2m]!;
  final temperatures = data.values;

  print(temperatures);
}
