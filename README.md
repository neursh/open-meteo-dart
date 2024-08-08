# Open-Meteo API SDK
A simple, fast, asynchronous Dart/Flutter package for accessing the Open-Meteo API.

All features from the [Open-Meteo API](https://open-meteo.com/en/features) are implemented (some limited).
Be sure to read Open Meteo's [Terms of Use](https://open-meteo.com/en/terms/) before using this package in your project.

## Top Contributors
 <table>
  <tr>
    <td align="center">
      <img valign="top" width="80px" src="https://avatars.githubusercontent.com/u/89086035?v=4" />
      <br>
      <a href="https://github.com/MathNerd28">MathNerd28</a>
      <br>
      <a href="https://github.com/neursh/open-meteo-dart/pulls?q=is%3Apr+author%3AMathNerd28">🛠️</a> | 💛 v1.1.0 - v2
    </td>
  </tr>
</table>

## Usage & Docs
Each of the nine features available in Open-Meteo is represented by its own class: `WeatherApi`, `HistoricalApi`, `EnsembleApi`, `ClimateApi`, `MarineApi`, `AirQualityApi`, `GeocodingApi`, `ElevationApi` and `FloodApi`.

> [!NOTE]
> All inputs to the API have been adapted to Dart-friendly variables.
> Time arguments are `DateTime` objects, and many parameters have enum representations.

For example, to get the hourly temperature in London, 2 meters above sea level using `WeatherApi`, and only get information from `2024-08-10` to `2024-08-12`:

```dart
import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi();
  final response = await weather.request(
    latitude: 52.52,
    longitude: 13.41,
    hourly: {WeatherHourly.temperature_2m},
    startDate: DateTime(2024, 8, 10),
    endDate: DateTime(2024, 8, 12),
  );
  final data = response.hourlyData[WeatherHourly.temperature_2m]!;
  final currentTemperature = data.values;

  print(currentTemperature);
}
```

In this example, the result is a `Map<DateTime, double>`:
```
{
  2024-08-08 05:00:00.000: 20.09549903869629,
  2024-08-08 06:00:00.000: 19.89550018310547,
  ...,
  2024-08-13 03:00:00.000: 18.788999557495117,
  2024-08-13 04:00:00.000: 17.288999557495117,
}
```

> [!TIP]
> In each API, there are two main method:
> 
> - `request` returns a Dart object, and throws an exception if the API returns an error response, recommended for most use cases.
> 
> - `requestJson` returns a JSON map, containing either the data or the raw error response. This method exists solely for debug purposes, do not use in production.

> [!NOTE]
> The `Geocoding` and `Elevation` are the two exceptions as they only have `searchJson` method available, the upstream API doesn't implement FlatBuffers.

```dart
var result = await GeocodingApi().requestJson(name: "London");
```
```dart
var result = await ElevationApi().requestJson(latitudes: [52.52], longitudes: [13.41]);
```

## Bugs & Pull requests
Before reporting an issue, please check Open-Meteo's docs to make sure you're calling the correct endpoint with the correct arguments.
Contributions are welcome!
