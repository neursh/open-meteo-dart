import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi();
  final response = await weather.request(
    models: {
      OpenMeteoModel.best_match,
      OpenMeteoModel.ecmwf_ifs025,
    },
    latitude: 52.52,
    longitude: 13.41,
    hourly: {WeatherHourly.temperature_2m},
  );

  for (final segment in response.segments) {
    print(
        '${segment.model} : ${segment.hourlyData[WeatherHourly.temperature_2m]!.values}');
  }
}
