import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi();
  final response = await weather.request(
      models: {
        OpenMeteoModel.best_match,
        OpenMeteoModel.ecmwf_ifs025,
      },
      locations: {
        OpenMeteoLocation(latitude: 16.16667, longitude: 107.83333),
        OpenMeteoLocation(latitude: 52.52, longitude: 13.41),
      },
      hourly: {
        WeatherHourly.temperature_2m
      },
      overrideUri: (url) {
        print(url);
        return url;
      });

  for (final segment in response.segments) {
    print(
        '${segment.longitude},${segment.latitude} : ${segment.model} : ${segment.hourlyData[WeatherHourly.temperature_2m]!.values.length}');
  }
}
